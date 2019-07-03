class ConsultationBill < ApplicationRecord
  validates :price, presence: true

  belongs_to :medical_consultation
end