class Permission < ApplicationRecord
  validates :permission_date, presence: true

  belongs_to :user, dependent: :destroy
end
