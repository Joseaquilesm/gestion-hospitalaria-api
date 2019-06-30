class CreateOrderDoses < ActiveRecord::Migration[5.2]
  def change
    create_table :order_doses do |t|
      t.references :medical_order, foreign_key: true
      t.references :dose, foreign_key: true
      t.timestamps
    end
  end
end
