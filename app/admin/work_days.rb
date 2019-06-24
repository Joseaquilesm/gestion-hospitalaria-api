ActiveAdmin.register WorkDay do
  permit_params :monday, :tuesday, :wednesday, :thursday, :friday,
                :saturday, :sunday
end
