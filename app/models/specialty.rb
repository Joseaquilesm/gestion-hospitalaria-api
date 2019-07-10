class Specialty < ApplicationRecord
  validates :name, presence: true
  has_one :user, dependent: :destroy

  has_many :medical_consultations

  def display_name
    "#{name.capitalize}"
  end
end
