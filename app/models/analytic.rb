class Analytic < ApplicationRecord

  has_one :medical_consultation

  def display_name
    "Análisis ##{id}"
  end

  def get_all_attrs
    attributes
  end
end