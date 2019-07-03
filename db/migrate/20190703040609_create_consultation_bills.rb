class CreateConsultationBills < ActiveRecord::Migration[5.2]
  def change
    create_table :consultation_bills do |t|
      t.references :medical_consultation, foreign_key: true
      t.float :price
      t.timestamps
    end
  end
end
