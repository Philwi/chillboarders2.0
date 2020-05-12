class AddUserSpotForeignKeyToComments < ActiveRecord::Migration[6.0]
  def change
    add_reference :comments, :user_site, index: true
    add_reference :comments, :active_storage_attachments, index: true
  end
end
