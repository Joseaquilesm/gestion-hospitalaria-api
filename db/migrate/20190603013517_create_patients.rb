class CreatePatients < ActiveRecord::Migration[5.2]
  def change
    create_table :patients do |t|
      t.integer :person_id
      t.string :blood_type
      t.boolean :insured
      t.string :insurance_carrier
      t.string :insurance_number
      t.string :scholarship
      t.boolean :studying
      t.string :study_place
      t.boolean :private_education
      t.boolean :working
      t.string :working_place
      t.string :occupation
      t.float :fixed_income
      t.integer :working_family_members
      t.string :working_hours
      t.string :housing_type
      t.integer :cohabitants_number
      t.boolean :home_insurance
      t.string :home_insurance_carrier
      t.string :recreation_place
      t.string :recreation_frequency
      t.timestamps
    end
  end
end
