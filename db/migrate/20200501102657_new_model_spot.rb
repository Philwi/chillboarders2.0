class NewModelSpot < ActiveRecord::Migration[6.0]
  def change
    create_table :spots do |t|
      t.string :title
      t.string :description
      t.string :type
      t.float :lat
      t.float :lng
      t.belongs_to :user
      t.timestamps
    end
  end
end
