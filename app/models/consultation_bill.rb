class ConsultationBill < ApplicationRecord
  validates :price, presence: true

  belongs_to :medical_consultation, optional: true

  def display_name
    "##{id} - $#{price}"
  end
end