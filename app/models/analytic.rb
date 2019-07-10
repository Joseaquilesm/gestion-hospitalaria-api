class Analytic < ApplicationRecord

  has_one :medical_consultation

  def display_name
    "Análisis ##{id}"
  end
end