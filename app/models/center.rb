class Center < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true

  has_many :medicines
end