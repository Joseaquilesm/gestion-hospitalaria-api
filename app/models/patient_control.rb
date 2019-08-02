class PatientControl < ApplicationRecord

  has_one :medical_consultation

  def display_name
    "Control ##{id}"
  end

  def get_all_attrs
    attributes
  end
end