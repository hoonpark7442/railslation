class AddCachedAuthorNameToRssFeed < ActiveRecord::Migration[6.1]
  def change
    add_column :rss_feeds, :cached_author_name, :string
  end
end
