class CreateRssFeeds < ActiveRecord::Migration[6.0]
  def change
    create_table :rss_feeds do |t|
      t.string :title
      t.string :link
      t.text :description
      t.string :author
      t.string :category
      t.string :guid
      t.string :pub_date
      t.string :source
      t.string :image_url
      t.timestamps
    end
  end
end
