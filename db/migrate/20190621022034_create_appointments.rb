class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.text :motive
      t.date :appointment_date
      t.string :hour_date
      t.belongs_to :doctor, class: 'User'
      t.belongs_to :secretary, class: 'User'
      t.references :patient, foreign_key: true
      t.timestamp :deleted_at
      t.timestamps
    end
  end
end
