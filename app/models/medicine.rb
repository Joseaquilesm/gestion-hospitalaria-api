class Medicine < ApplicationRecord
  validates :name, presence: true
  validates :quantity, presence: true

  belongs_to :center, optional: true
end