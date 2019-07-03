ActiveAdmin.register MedicalConsultation do
  permit_params :appointment_id, :medical_order_id, :patient_control_id, :consultation_motive, :current_disease_history,
                :psi_background, :childhood_background, :teen_background, :adult_background, :medicines_background, :allergies_background,
                :traumatic_background, :surgical_background, :psychosexual_sphere, :hospitalizations, :toxic_habits, :mother_background,
                :father_background, :siblings_background, :spouse_background, :others_background, :premorbid_personality, :family_constellation,
                :axis_1, :axis_2, :axis_3, :axis_4, :axis_5, :axis_extra, :diagnosis, :therapy, :consultation_summary
end
