class Medicine < ApplicationRecord
  validates :name, presence: true
  validates :quantity, presence: true

  has_many :doses
end