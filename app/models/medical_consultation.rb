class MedicalConsultation < ApplicationRecord

  belongs_to :appointment
  belongs_to :medical_order, optional: true
  belongs_to :patient_control, optional: true
  belongs_to :specialty
  belongs_to :analytic

  has_one :consultation_bill, dependent: :destroy

  def display_name
    "Consulta ##{id}"
  end
end