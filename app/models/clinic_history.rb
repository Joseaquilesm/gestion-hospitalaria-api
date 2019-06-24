class ClinicHistory < ApplicationRecord
  belongs_to :patient, dependent: :destroy
  belongs_to :toxic_habit, dependent: :destroy
end
