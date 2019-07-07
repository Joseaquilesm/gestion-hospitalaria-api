class MedicalConsultationsController < ApiController
  def index
    if params[:patient_id].present?
      @medical_consultations = MedicalConsultation.joins(:appointment).where(appointments: {patient_id: params[:patient_id]})
      render status: 200, json: {medical_consultations: @medical_consultations}
    else
      render status: 200, json: {error: true, message: 'Se debe especificar un paciente.'}
    end
  end

  def create
    @medical_consultation = MedicalConsultation.new(medical_consultation_params)
    begin
      ActiveRecord::Base.transaction do
        @analytic = Analytic.create!(analytic_params)
        @medical_consultation.analytic = @analytic
        @medical_consultation.save!
        @consultation_bill = ConsultationBill.create!(price: 0.0)
      end
      render status: 200, json: {message: 'La consulta se ha registrado exitosamente!'}
    rescue StandardError
      render status: 200, json: {error: true, messages: @medical_consultation.errors}
    end
  end

  def show
    @medical_consultation = MedicalConsultation.find_by_id(params[:id])
    if @medical_consultation.nil?
      render status: 200, json: {error: true, message: 'La consulta no existe!'}
    else
      render status: 200, json: {medical_consultation: @medical_consultation}
    end
  end

  def get_by_doctor
    @doctor = User.find_by_id(params[:id])
    if @doctor.nil?
      render status: 200, json: {error: true, message: 'El doctor no existe.'}
    else
      @medical_consultations = MedicalConsultation.joins(:appointment).where(appointments: {doctor_id: @doctor.id})
      render status: 200, json: {medical_consultations: @medical_consultations}
    end
  end

  private

  def medical_consultation_params
    params.permit(:appointment_id, :medical_order_id, :patient_control_id, :consultation_motive, :current_disease_history,
                  :psi_background, :childhood_background, :teen_background, :adult_background, :medicines_background, :allergies_background,
                  :traumatic_background, :surgical_background, :psychosexual_sphere, :hospitalizations, :toxic_habits, :mother_background,
                  :father_background, :siblings_background, :spouse_background, :others_background, :premorbid_personality, :family_constellation,
                  :axis_1, :axis_2, :axis_3, :axis_4, :axis_5, :axis_extra, :diagnosis, :therapy, :consultation_summary)
  end

  def analytic_params
    params.permit(:hemograma, :glicemia, :urea, :creatinina, :alt, :ast, :ggt, :na,
                  :k, :mg, :ca, :t4libre, :tsh, :albumina, :hbal, :amonio, :prolactina,
                  :hiv, :hcv, :hbsag, :tac_craneo, :ekg, :eeg, :irm_encefalo,
                  :espectroscopia, :otros)
  end
end
