class PatientControl < ApplicationRecord
  validates :observation, presence: true

  has_one :medical_consultation

  def display_name
    "Control ##{id}"
  end

  def get_all_attrs
    attributes
  end
end