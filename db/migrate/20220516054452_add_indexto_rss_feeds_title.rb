class AddIndextoRssFeedsTitle < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    add_index :rss_feeds, :title, algorithm: :concurrently
  end
end
