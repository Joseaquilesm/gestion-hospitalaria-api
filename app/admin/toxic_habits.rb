ActiveAdmin.register ToxicHabit do
  permit_params :coffee, :cups_per_day, :tizana, :tizana_type, :tizanas_per_day,
                :tobacco, :tobacco_per_day, :alcohol, :alcohol_type,
                :alcohol_per_day, :other_substances, :substances_details
end
