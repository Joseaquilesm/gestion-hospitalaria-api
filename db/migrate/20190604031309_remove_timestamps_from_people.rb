class RemoveTimestampsFromPeople < ActiveRecord::Migration[5.2]
  def change
    remove_column :people, :created_at, :datetime
    remove_column :people, :updated_at, :datetime
  end
end
