class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email, null: false
      t.string :body, null: false
      t.timestamps
    end
  end
end
