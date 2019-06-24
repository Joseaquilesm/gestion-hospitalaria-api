class ToxicHabit < ApplicationRecord
  has_one :clinic_history, dependent: :destroy

  def display_name
    clinic_history.patient.display_name
  end
end
