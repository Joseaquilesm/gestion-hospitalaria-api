class MedicalOrder < ApplicationRecord

  has_many :order_doses
  has_one :medical_consultation
end