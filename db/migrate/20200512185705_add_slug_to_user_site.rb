class AddSlugToUserSite < ActiveRecord::Migration[6.0]
  def change
    add_column :user_sites, :slug, :string
    add_index :user_sites, :slug, unique: true
  end
end
