class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.text :motive
      t.date :appointment_date
      t.string :hour_date
      t.boolean :previous_assistance
      t.boolean :accompanied
      t.string :consultation_type
      t.string :familiar_name
      t.string :familiar_relation
      t.string :familiar_phone_number
      t.belongs_to :doctor, class: 'User'
      t.belongs_to :secretary, class: 'User'
      t.references :patient, foreign_key: true
      t.references :specialty, foreign_key: true
      t.timestamp :deleted_at
      t.timestamps
    end
  end
end
