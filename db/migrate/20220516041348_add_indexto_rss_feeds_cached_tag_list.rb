class AddIndextoRssFeedsCachedTagList < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    # From <https://www.postgresql.org/docs/11/pgtrgm.html#id-1.11.7.40.7>
    # We need a GIN index on `cached_tag_list` to speed up `LIKE` queries
    add_index :rss_feeds, :cached_tag_list, using: :gin, opclass: :gin_trgm_ops, algorithm: :concurrently
  end
end
