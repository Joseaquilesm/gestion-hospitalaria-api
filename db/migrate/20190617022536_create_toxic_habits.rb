class CreateToxicHabits < ActiveRecord::Migration[5.2]
  def change
    create_table :toxic_habits do |t|
      t.boolean :coffee
      t.integer :cups_per_day
      t.boolean :tizana
      t.string :tizana_type
      t.integer :tizanas_per_day
      t.boolean :tobacco
      t.integer :tobacco_per_day
      t.boolean :alcohol
      t.string :alcohol_type
      t.integer :alcohol_per_day
      t.boolean :other_substances
      t.string :substances_details
    end
  end
end
