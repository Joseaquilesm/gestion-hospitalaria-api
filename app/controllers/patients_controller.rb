class PatientsController < ApiController
  before_action :authorize_request
  before_action :verify_users_patients

  def index
    patients = Patient.all
    @obj = []
    patients.each do |patient|
      @p = fill_info(patient)
      @obj.push(@p)
    end
    render status: 200, json: {patients: @obj}
  end

  def create
    @person = Person.new(person_params)
    @patient = Patient.new(patient_params)
    begin
      ActiveRecord::Base.transaction do
        @person.save!
        @patient.person = @person
        @patient.save!
      end
      render status: 200, json: {message: 'Paciente creado exitosamente!'}
    rescue StandardError
      @messages = get_errors(@person, @patient)
      render status: 200, json: {error: true, messages: @messages}
    end
  end

  def show
    patient = Patient.find_by_id(params[:id])
    render status: 200, json: {error: true, message: 'El paciente no existe'} if patient.nil?
    @obj = {}
    unless patient.nil?
      @obj = fill_info(patient)
      render status: 200, json: {patient: @obj}
    end
  end

  def update
    @patient = Patient.find_by_id(params[:id])
    render status: 200, json: {error: true, message: 'El paciente no existe'} if @patient.nil?
    unless @patient.nil?
      @person = @patient.person
      begin
        ActiveRecord::Base.transaction do
          @person.update!(person_params)
          @patient.update!(patient_params)
        end
        render status: 200, json: {message: 'Paciente actualizado exitosamente!'}
      rescue StandardError
        @messages = get_errors(@patient, @person)
        render status: 200, json: {error: true, messages: @messages}
      end
    end
  end

  def get_patient_controls
    @patient = Patient.find_by_id(params[:id])
    render status: 200, json: {error: true, message: 'El paciente no existe'} if @patient.nil?
    unless @patient.nil?
      @obj = get_all_controls(@patient.id)
      render status: 200, json: {controls: @obj}
    end
  end

  private

  def patient_params
    params.permit(:blood_type, :insured, :insurance_carrier, :insurance_number, :scholarship,
                  :studying, :study_place, :private_education, :working, :working_place,
                  :occupation, :fixed_income, :working_family_members, :working_hours,
                  :housing_type, :cohabitants_number, :home_insurance, :home_insurance_carrier,
                  :recreation_place, :recreation_frequency, :religion)
  end

  def get_errors(person, patient)
    messages = {}
    fill_errors(person.errors, messages)
    fill_errors(patient.errors, messages)
    messages
  end

  def fill_info(patient)
    obj = {}
    obj.merge!(id: patient.id)
    obj.merge!(patient.person.attributes.except('id'))
    obj.merge!(patient.attributes.except('person_id'))
    obj
  end

  def get_all_controls(id)
    all_a = Appointment.with_deleted.where(patient_id: id)
    filtered = []

    all_a.each do |a|
      mc = MedicalConsultation.find_by_appointment_id(a.id)
      control = nil
      control = PatientControl.find_by_id(mc.patient_control_id) unless mc.nil?
      filtered.push(control.get_all_attrs) unless control.nil?
    end
    return filtered
  end
end
