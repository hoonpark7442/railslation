class AddRssFeedsIdToArticles < ActiveRecord::Migration[6.1]
  def change
    add_reference :articles, :rss_feed, index: true
  end
end
