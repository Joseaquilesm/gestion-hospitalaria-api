class MedicalConsultationsController < ApiController

  before_action :authorize_request
  before_action :verify_users_consultations

  def index
    @medical_consultations = MedicalConsultation.all
    @obj = fill_info(@medical_consultations)
    render status: 200, json: {medical_consultations: @obj}
  end

  def create
    @specialty = Specialty.find_by_name(params[:specialty])
    @appointment = Appointment.find_by_id(params[:appointment_id])
    @analytic = Analytic.new(analytic_params)
    @patient_control = PatientControl.new(patient_control_params)
    @medical_consultation = MedicalConsultation.new(medical_consultation_params)
    @consultation_bill = ConsultationBill.new(price: 0.0);
    begin
      ActiveRecord::Base.transaction do
        @analytic.save!
        @patient_control.save!
        @consultation_bill.save!
        @medical_consultation.specialty = @specialty
        @medical_consultation.appointment = @appointment
        @medical_consultation.analytic = @analytic
        @medical_consultation.patient_control = @patient_control
        @medical_consultation.save!
        @consultation_bill.medical_consultation = @medical_consultation
        @consultation_bill.save!
        @medical_consultation.appointment.destroy # Se archiva la cita
      end
      render status: 200, json: {message: 'La consulta se ha registrado exitosamente!'}
    rescue StandardError
      @obj = {}
      fill_errors(@analytic.errors, @obj)
      fill_errors(@patient_control.errors, @obj) unless @patient_control.nil?
      fill_errors(@medical_consultation.errors, @obj)
      fill_errors(@consultation_bill.errors, @obj)
      render status: 200, json: {error: true, messages: @obj}
    end
  end

  def show
    @medical_consultation = MedicalConsultation.find_by_id(params[:id])
    if @medical_consultation.nil?
      render status: 200, json: {error: true, message: 'La consulta no existe.'}
    else
      render status: 200, json: {medical_consultation: @medical_consultation.get_all_attrs}
    end
  end

  def get_by_doctor
    @doctor = User.find_by_id(params[:id])
    if @doctor.nil?
      render status: 200, json: {error: true, message: 'El doctor no existe.'}
    else
      @medical_consultations = get_all_by_doctor(@doctor.id)
      render status: 200, json: {medical_consultations: @medical_consultations}
    end
  end

  def get_by_patient
    @patient = Patient.find_by_id(params[:id])
    if @patient.nil?
      render status: 200, json: {error: true, message: 'El paciente no existe.'}
    else
      @medical_consultations = get_all_by_patient(@patient.id)
      render status: 200, json: {medical_consultations: @medical_consultations}
    end
  end

  private

  def medical_consultation_params
    params.permit(:appointment_id, :consultation_motive, :current_disease_history,
                  :psi_background, :childhood_background, :teen_background, :adult_background, :medicines_background, :allergies_background,
                  :traumatic_background, :surgical_background, :psychosexual_sphere, :hospitalizations, :toxic_habits, :mother_background,
                  :father_background, :siblings_background, :spouse_background, :others_background, :premorbid_personality, :family_constellation,
                  :axis_1, :axis_2, :axis_3, :axis_4, :axis_5, :axis_extra, :diagnosis, :therapy, :consultation_summary)
  end

  def analytic_params
    params.permit(:hemograma, :glicemia, :urea, :creatinina, :alt, :ast, :ggt, :na,
                  :k, :mg, :ca, :t4libre, :tsh, :albumina, :hba1, :amonio, :prolactina,
                  :hiv, :hcv, :hbsag, :tac_craneo, :ekg, :eeg, :irm_encefalo,
                  :espectroscopia, :others)
  end

  def patient_control_params
    params.permit(:heart_rate, :blood_pressure, :weight, :observation)
  end

  def fill_info(consultations)
    obj = []
    consultations.each do |consultation|
      obj.push(consultation.get_all_attrs)
    end
    obj
  end

  def get_all_by_doctor(id)
    all_a = Appointment.with_deleted.where(doctor_id: id)
    filtered = []

    all_a.each do |a|
      mc = MedicalConsultation.find_by_appointment_id(a.id)
      filtered.push(mc.get_all_attrs) unless mc.nil?
    end

    return filtered
  end

  def get_all_by_patient(id)
    all_a = Appointment.with_deleted.where(patient_id: id)
    filtered = []

    all_a.each do |a|
      mc = MedicalConsultation.find_by_appointment_id(a.id)
      filtered.push(mc.get_all_attrs) unless mc.nil?
    end

    return filtered
  end
end
