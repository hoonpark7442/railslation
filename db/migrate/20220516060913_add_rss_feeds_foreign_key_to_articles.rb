class AddRssFeedsForeignKeyToArticles < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :articles, :rss_feeds, on_delete: :nullify, validate: false
  end
end
