ActiveAdmin.register Patient do
  permit_params :person_id, :blood_type, :insured, :insurance_carrier, :insurance_number, :scholarship,
                :studying, :study_place, :private_education, :working, :working_place,
                :occupation, :fixed_income, :working_family_members, :working_hours,
                :housing_type, :cohabitants_number, :home_insurance, :home_insurance_carrier,
                :recreation_place, :recreation_frequency, :religion
end
