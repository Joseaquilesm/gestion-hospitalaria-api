# frozen_string_literal: true

ActiveAdmin.register MedicalConsultation do
  permit_params :current_disease_history, :analytics_and_procedures, :diagnosis, :consultation_summary, :background, :appointment_id
end
