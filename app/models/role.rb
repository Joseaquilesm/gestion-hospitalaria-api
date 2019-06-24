class Role < ApplicationRecord
  has_one :user, dependent: :destroy

  def display_name
    "#{name.capitalize}"
  end
end
