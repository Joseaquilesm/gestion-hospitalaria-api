class MedicalConsultation < ApplicationRecord
  belongs_to :appointment
  belongs_to :medical_order, optional: true
  belongs_to :patient_control, optional: true
  belongs_to :specialty
  belongs_to :analytic

  def display_name
    "Consulta ##{id}"
  end
end