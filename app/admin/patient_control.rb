ActiveAdmin.register PatientControl do
  permit_params :heart_rate, :blood_pressure, :weight, :observation
end
