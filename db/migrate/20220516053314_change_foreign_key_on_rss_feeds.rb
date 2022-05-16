class ChangeForeignKeyOnRssFeeds < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :rss_feeds, column: :author_id
    add_foreign_key :rss_feeds, :authors, column: :author_id, on_delete: :cascade
  end
end
