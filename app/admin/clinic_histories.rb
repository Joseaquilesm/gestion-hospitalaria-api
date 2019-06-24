ActiveAdmin.register ClinicHistory do
  permit_params :patient_id, :toxic_habit_id, :premorbid_personality, :family_constellation,
                :axis_1, :axis_2, :axis_3, :axis_4, :axis_5,
                :additional_comment, :initial_psychiatric_management
end
