class WorkDay < ApplicationRecord
  has_one :user, dependent: :destroy

  def display_name
    "WorkDay ##{id}"
  end
end
