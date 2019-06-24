class Specialty < ApplicationRecord
  validates :name, presence: true
  has_one :user, dependent: :destroy

  def display_name
    "#{name.capitalize}"
  end
end
