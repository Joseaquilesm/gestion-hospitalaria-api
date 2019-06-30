class CreateDoses < ActiveRecord::Migration[5.2]
  def change
    create_table :doses do |t|
      t.references :medicine, foreign_key: true
      t.string :frequency
      t.integer :days
      t.timestamps
    end
  end
end
