class User < ApplicationRecord
  validates :role_id, presence: true
  validates :specialty_id, presence: true, :if => :doctor?
  validates :entry_time, presence: true
  validates :departure_time, presence: true

  belongs_to :person, optional: true, dependent: :destroy
  belongs_to :role
  belongs_to :specialty, optional: true
  belongs_to :work_day, optional: true, dependent: :destroy

  has_many :vacations
  has_many :appointments
  has_many :references
  # has_and_belongs_to_many :vacation
  # has_and_belongs_to_many :medic_license
  # has_and_belongs_to_many :permission

  def doctor?
    role.name == 'doctor' unless role.nil?
  end

  def display_name
    person.identification + ' - ' + person.name + ' ' + person.last_name
  end
end
