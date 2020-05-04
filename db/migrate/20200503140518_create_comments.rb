class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string :description, null: false
      t.belongs_to :user
      t.belongs_to :spot
      t.timestamps
    end
  end
end
