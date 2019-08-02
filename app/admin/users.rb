ActiveAdmin.register User do
  permit_params :person_id, :specialty_id, :role_id, :work_day_id,
                :entry_time, :departure_time, :password, :password_confirmation
end
