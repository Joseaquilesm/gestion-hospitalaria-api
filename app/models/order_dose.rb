class OrderDose < ApplicationRecord
  validates :dose_id, presence:true
  validates :medical_order_id, presence:true

  belongs_to :dose
  belongs_to :medical_order
end