class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def delete_appointments
    appointments.with_deleted.each do |a|
      a.really_destroy!
    end
  end
end
