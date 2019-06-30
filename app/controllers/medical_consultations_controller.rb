# frozen_string_literal: true

class MedicalConsultationsController < ApiController
  def index
    if params[:patient_id].present?
      @medical_consultations = MedicalConsultation.joins(:appointment).where(appointments: { patient_id: params[:patient_id] })
      render status: 200, json: { medical_consultations: @medical_consultations }
    else
      render status: 200, json: { error: true, message: 'Se debe especificar un paciente.' }
    end
  end

  def create
    @medical_consultation = MedicalConsultation.new(medical_consultation_params)
    begin
      ActiveRecord::Base.transaction do
        @medical_consultation.save!
      end
      render status: 200, json: { message: 'La consulta se ha registrado exitosamente!' }
    rescue StandardError
      render status: 200, json: { error: true, messages: @medical_consultation.errors }
    end
  end

  private

  def medical_consultation_params
    params.permit(:appointment_id, :current_disease_history, :analytics_and_procedures, :diagnosis, :consultation_summary, :background)
  end
end
