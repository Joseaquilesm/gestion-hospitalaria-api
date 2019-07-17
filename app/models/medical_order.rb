class MedicalOrder < ApplicationRecord
  has_one :medical_consultation
end