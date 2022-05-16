class CreateRssFeeds < ActiveRecord::Migration[6.1]
  def change
    create_table :rss_feeds do |t|
      t.references :author, null: false, foreign_key: true
      t.string :title, null: false
      t.string :feed_source_url, null: false
      t.datetime :published_at
      t.string :cached_tag_list
      t.boolean :translated, null: false, default: false

      t.timestamps
    end
  end
end
