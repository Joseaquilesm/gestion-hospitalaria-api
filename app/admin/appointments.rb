ActiveAdmin.register Appointment do
  permit_params :motive, :appointment_date, :doctor_id, :secretary_id, :patient_id, :hour_date
  active_admin_paranoia
end
