class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :identification
      t.string :name
      t.string :last_name
      t.string :address
      t.string :phone_number
      t.string :genre
      t.date :birthday
      t.string :birth_place
      t.string :nationality
      t.string :email
      t.string :civil_status
      t.string :religion
      t.timestamps
    end
  end
end
