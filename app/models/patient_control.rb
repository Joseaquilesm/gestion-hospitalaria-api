class PatientControl < ApplicationRecord
  validates :observation, presence: true

  has_one :medical_consultation
end