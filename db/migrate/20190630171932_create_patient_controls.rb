class CreatePatientControls < ActiveRecord::Migration[5.2]
  def change
    create_table :patient_controls do |t|
      t.float :heart_rate
      t.float :blood_pressure
      t.float :weight
      t.text :observation
      t.timestamps
    end
  end
end
