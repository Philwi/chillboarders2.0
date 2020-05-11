class AddUserSpotForeignKeyToComments < ActiveRecord::Migration[6.0]
  def change
    add_reference :comments, :user_site, index: true
  end
end
