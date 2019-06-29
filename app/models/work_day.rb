class WorkDay < ApplicationRecord
  has_one :user, dependent: :destroy

  attribute :monday, :boolean, default: false
  attribute :tuesday, :boolean, default: false
  attribute :wednesday, :boolean, default: false
  attribute :thursday, :boolean, default: false
  attribute :friday, :boolean, default: false
  attribute :saturday, :boolean, default: false
  attribute :sunday, :boolean, default: false

  def display_name
    "WorkDay ##{id}"
  end
end
