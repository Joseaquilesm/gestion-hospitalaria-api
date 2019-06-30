class CreateReferences < ActiveRecord::Migration[5.2]
  def change
    create_table :references do |t|
      t.boolean :internal_reference
      t.references :center, foreign_key: true
      t.belongs_to :doctor, class: 'User'
      t.string :external_reference
      t.timestamps
    end
  end
end
