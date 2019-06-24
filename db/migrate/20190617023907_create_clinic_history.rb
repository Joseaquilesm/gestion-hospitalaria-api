class CreateClinicHistory < ActiveRecord::Migration[5.2]
  def change
    create_table :clinic_histories do |t|
      t.string :premorbid_personality
      t.string :family_constellation
      t.string :axis_1
      t.string :axis_2
      t.string :axis_3
      t.string :axis_4
      t.string :axis_5
      t.string :additional_comment
      t.string :initial_psychiatric_management
      t.references :toxic_habit, foreign_key: true
      t.references :patient, foreign_key: true
    end
  end
end
