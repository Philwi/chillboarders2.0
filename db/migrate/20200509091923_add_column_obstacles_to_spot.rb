class AddColumnObstaclesToSpot < ActiveRecord::Migration[6.0]
  def change
    add_column :spots, :obstacles, :string, array: :true, default: []
  end
end
