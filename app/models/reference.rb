class Reference < ApplicationRecord
  validates :center_id, presence: true, if: -> {internal_reference == true}
  validates :doctor_id, presence: true, if: -> {internal_reference == true}
  validates :external_reference, presence: true, if: -> {internal_reference == false}

  belongs_to :doctor, :class_name => 'User', optional: true
  belongs_to :center, optional: true
  has_one :appointment
  has_one :medical_consultation
end
