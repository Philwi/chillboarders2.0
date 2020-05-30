class CreateUserMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :user_messages do |t|
      t.string :body, null: false
      t.integer :for_user_id
      t.boolean :read, default: false
      t.belongs_to :user
      t.timestamps
    end
  end
end
