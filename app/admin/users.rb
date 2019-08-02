ActiveAdmin.register User do
  permit_params :person_id, :specialty_id, :role_id, :work_day_id,
                :entry_time, :departure_time, :password, :password_confirmation

  form do |f|
    f.inputs do
      f.semantic_errors
      f.input :person_id, :as => :select, :collection => Person.all.map { |u| [u.display_name, u.id] }
      f.input :specialty_id, :as => :select, :collection => Specialty.all.map { |u| [u.display_name, u.id] }
      f.input :role_id, :as => :select, :collection => Role.all.map { |u| [u.display_name, u.id] }
      f.input :work_day_id, :as => :select, :collection => WorkDay.all.map { |u| [u.display_name, u.id] }
      f.input :entry_time
      f.input :departure_time
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
