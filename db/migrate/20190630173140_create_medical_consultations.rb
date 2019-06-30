class CreateMedicalConsultations < ActiveRecord::Migration[5.2]
  def change
    create_table :medical_consultations do |t|
      t.references :appointment, foreign_key: true
      t.references :medical_order, foreign_key: true
      t.references :reference, foreign_key: true
      t.references :patient_control, foreign_key: true
      t.text :current_disease_history
      t.text :analytics_and_procedures
      t.text :diagnosis
      t.text :consultation_summary
      t.text :background
      t.timestamps

    end
  end
end