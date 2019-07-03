class MedicalConsultation < ApplicationRecord
  validates :consultation_motive, presence: true
  validates :appointment_id, presence: true
  validates :consultation_summary, presence: true
  validates :current_disease_history, presence: true

  belongs_to :appointment
  belongs_to :patient_control, optional: true
  belongs_to :medical_order, optional: true
end