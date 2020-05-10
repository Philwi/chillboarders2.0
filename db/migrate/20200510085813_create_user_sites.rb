class CreateUserSites < ActiveRecord::Migration[6.0]
  def change
    create_table :user_sites do |t|
      t.string :headline
      t.string :text
      t.string :tricks, array: true, default: [], null: false
      t.string :embedded_music_player_html
      t.string :primary_color, default: '#59d163'
      t.string :secondary_color, default: '#f6f6f6'
      t.string :tertiary_color, default: '#212121'
      t.belongs_to :user
      t.timestamps
    end
  end
end