class CreateContests < ActiveRecord::Migration[6.0]
  def change
    create_table :contests do |t|
      t.string :title
      t.string :src
      t.date :date
      t.string :description
      t.string :location
      t.string :link
      t.timestamps
    end
  end
end