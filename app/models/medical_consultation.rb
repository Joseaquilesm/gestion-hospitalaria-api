class MedicalConsultation < ApplicationRecord

  belongs_to :appointment
  belongs_to :medical_order, optional: true
  belongs_to :patient_control, optional: true
  belongs_to :specialty
  belongs_to :analytic

  has_one :consultation_bill, dependent: :destroy

  def appointment
    Appointment.unscoped {super}
  end

  def display_name
    "Consulta ##{id}"
  end

  def get_attrs
    attributes.except(:appointment_id.to_s, :medical_order_id.to_s, :patient_control_id.to_s, :specialty_id.to_s, :analytic_id.to_s)
  end

  def get_all_attrs
    get_attrs.merge(appointment: appointment.get_all_attrs, specialty: specialty.name, analytic: analytic.get_all_attrs, patient_control: patient_control.attributes)
  end
end