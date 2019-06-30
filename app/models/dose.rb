class Dose < ApplicationRecord
  validates :medicine_id, presence: true
  validates :frequency, presence: true
  validates :days, presence: true

  belongs_to :medicine
  has_many :order_doses
end