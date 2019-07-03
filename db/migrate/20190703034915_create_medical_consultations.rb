class CreateMedicalConsultations < ActiveRecord::Migration[5.2]
  def change
    create_table :medical_consultations do |t|
      t.references :appointment, foreign_key: true
      t.references :medical_order, foreign_key: true
      t.references :patient_control, foreign_key: true
      t.references :specialty, foreign_key: true
      t.references :analytic, foreign_key: true
      t.text :consultation_motive
      t.text :current_disease_history
      t.text :psi_background
      t.text :childhood_background
      t.text :teen_background
      t.text :adult_background
      t.text :medicines_background
      t.text :allergies_background
      t.text :traumatic_background
      t.text :surgical_background
      t.text :psychosexual_sphere
      t.text :hospitalizations
      t.text :toxic_habits
      t.text :mother_background
      t.text :father_background
      t.text :siblings_background
      t.text :spouse_background
      t.text :others_background
      t.text :premorbid_personality
      t.text :family_constellation
      t.text :axis_1
      t.text :axis_2
      t.text :axis_3
      t.text :axis_4
      t.text :axis_5
      t.text :axis_extra
      t.text :diagnosis
      t.text :therapy
      t.text :consultation_summary
      t.timestamps

    end
  end
end
