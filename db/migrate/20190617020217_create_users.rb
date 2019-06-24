class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.references :person, foreign_key: true
      t.references :specialty, foreign_key: true
      t.references :role, foreign_key: true
      t.references :work_day, foreign_key: true
      t.string :entry_time
      t.string :departure_time
    end
  end
end
