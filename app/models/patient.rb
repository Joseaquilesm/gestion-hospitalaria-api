class Patient < ApplicationRecord
  validates :insurance_carrier, presence: true, if: -> {insured == true}
  validates :insurance_number, presence: true, if: -> {insured == true}
  # Verificar con lo que envia React
  validates :scholarship, presence: true
  validates :study_place, presence: true, if: -> {studying == true}
  validates :working_place, presence: true, if: -> {working == true}
  validates :occupation, presence: true, if: -> {working == true}
  validates :working_family_members, numericality: {greater_than_or_equal_to: 0}
  # Esperar que se decida lo del tipo de vivienda
  validates :cohabitants_number, numericality: {greater_than_or_equal_to: 0}
  validates :home_insurance_carrier, presence: true, if: -> {home_insurance == true}
  validates :religion, presence: true

  # Hay que agregar los valores por default

  belongs_to :person, optional: true, dependent: :destroy
  has_one :clinic_history, dependent: :destroy

  def display_name
    person.identification + ' - ' + person.name + ' ' + person.last_name
  end
end
