class PatientsController < ApiController
  def index
    @patients = Patient.all
    @obj = []
    @patients.each do |patient|
      @obj.push(patient.person.attributes.merge(patient.attributes.except('person_id')))
    end
    render status: 200, json: {patients: @obj}
  end

  def create
    @person = Person.new(person_params)
    @patient = Patient.new(patient_params)
    @person.save if @person.valid? && @patient.valid?
    @patient.person = @person if @person.id?
    @patient.save if @patient.valid? && @person.id?
    if @patient.id?
      ClinicHistory.create(toxic_habit: ToxicHabit.create, patient: @patient)
      render status: 200, json: {
          message: "El paciente ha sido creado exitosamente!"
      }
    else
      @messages = {}
      fill_errors(@person.errors, @messages)
      fill_errors(@patient.errors, @messages)
      render status: 200, json: {
          error: true, messages: @messages
      }
    end
  end

  def show
    @patient = Patient.find_by_id(params[:id])
    render status: 200, json: {error: true, message: 'El paciente no existe'} if @patient.nil?
    unless @patient.nil?
      @obj = @patient.person.attributes.merge(@patient.attributes.except('person_id'))
      render status: 200, json: {
          patient: @obj
      }
    end
  end

  def update
    @patient = Patient.find_by_id(params[:id])
    render json: {error: true, message: 'El paciente no existe'} if @patient.nil?
    unless @patient.nil?
      render json: {message: 'Se han actualizado los datos del paciente exitosamente!'} if @patient.person.update(person_params) &&
          @patient.update(patient_params)
      unless @patient.person.errors.empty? && @patient.errors.empty?
        @messages = {}
        fill_errors(@patient.person.errors, @messages)
        fill_errors(@patient.errors, @messages)
        render status: 200, json: {
            error: true, messages: @messages
        }
      end
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
end
