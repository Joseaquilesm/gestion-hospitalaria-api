class CreateMedicLicenses < ActiveRecord::Migration[5.2]
  def change
    create_table :medic_licenses do |t|
      t.date :start_date
      t.date :end_date
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
