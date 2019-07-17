class DropDosesTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :order_doses
    drop_table :doses
  end
end
