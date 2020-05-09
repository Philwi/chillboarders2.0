class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings do |t|
      t.float :rating, limit: 5, null: false

      t.belongs_to :user
      t.belongs_to :spot
      t.timestamps
    end
  end
end
