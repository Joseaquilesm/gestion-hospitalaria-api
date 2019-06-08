class Person < ApplicationRecord
  before_save {self.email = email.downcase unless email.blank?}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :identification, presence: true, uniqueness: true
  validates :name, presence: true
  validates :last_name, presence: true
  validates :genre, inclusion: {in: %w[M F]}
  validates :birthday, presence: true
  validates :email, uniqueness: {case_sensitive: false}, format: {with: VALID_EMAIL_REGEX}, if: -> {!email.blank?}
  # Falta el inclusion (verificar que manda React)
  validates :civil_status, presence: true
  validates :religion, presence: true

  has_one :patient
end
