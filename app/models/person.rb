class Person < ApplicationRecord
  before_save {self.email = email.downcase unless email.blank?}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :identification, presence: true, uniqueness: true
  validates :name, presence: true
  validates :last_name, presence: true
  validates :genre, inclusion: {in: %w[Masculino Femenino]}
  validates :birthday, presence: true
  validates :email, presence: true, uniqueness: {case_sensitive: false}, format: {with: VALID_EMAIL_REGEX}
  # Falta el inclusion (verificar que manda React)
  validates :civil_status, presence: true

  has_one :patient, dependent: :destroy
  has_one :user, dependent: :destroy

  def display_name
    identification + ' - ' + name + ' ' + last_name
  end
end
