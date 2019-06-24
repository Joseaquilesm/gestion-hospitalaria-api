class Appointment < ApplicationRecord
  validates :appointment_date, presence: true
  validates :hour_date, presence: true
  validates :patient_id, presence: true
  validates :doctor_id, presence: true
  validates :secretary_id, presence: true

  belongs_to :doctor, :class_name => 'User'
  belongs_to :secretary, :class_name => 'User'
  belongs_to :patient

  acts_as_paranoid
end
