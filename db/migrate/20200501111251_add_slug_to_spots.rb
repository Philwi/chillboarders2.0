class AddSlugToSpots < ActiveRecord::Migration[6.0]
  def change
    add_column :spots, :slug, :string
    add_index :spots, :slug, unique: true
  end
end
