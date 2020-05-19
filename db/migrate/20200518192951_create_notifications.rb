class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.string :type, null: false
      t.integer :from_user_id
      t.boolean :seen, default: false

      t.belongs_to :user
      t.belongs_to :user_site
      t.belongs_to :spot
      t.belongs_to :active_storage_attachments
      t.timestamps
    end
  end
end
