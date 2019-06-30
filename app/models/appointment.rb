# frozen_string_literal: true

class Appointment < ApplicationRecord
  validates :appointment_date, presence: true
  validates :hour_date, presence: true
  validates :patient_id, presence: true
  validates :doctor_id, presence: true
  validates :secretary_id, presence: true

  belongs_to :doctor, class_name: 'User'
  belongs_to :secretary, class_name: 'User'
  belongs_to :patient
  belongs_to :reference, optional: true
  has_one :medical_consultation

  acts_as_paranoid

  def display_name
    patient.person.name + ' ' + patient.person.last_name + ' ' + appointment_date.strftime('%d/%m/%Y') +
      ' a las ' + hour_date + ' con ' + doctor.person.name + ' ' + doctor.person.last_name
  end
end
