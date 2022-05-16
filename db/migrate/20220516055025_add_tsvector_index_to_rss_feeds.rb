class AddTsvectorIndexToRssFeeds < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def up
    query = <<-SQL
      ((((
        to_tsvector('simple'::regconfig, COALESCE((feed_source_url)::text, ''::text))) ||
        to_tsvector('simple'::regconfig, COALESCE((title)::text, ''::text
      )))))
    SQL

    unless index_name_exists?(:rss_feeds, :index_rss_feeds_on_search_fields_as_tsvector)
      add_index :rss_feeds,
                query,
                using: :gin,
                name: :index_rss_feeds_on_search_fields_as_tsvector,
                algorithm: :concurrently
    end


    
  end

  def down
    if index_name_exists?(:podcast_episodes, :index_rss_feeds_on_search_fields_as_tsvector)
      remove_index :podcast_episodes,
                   name: :index_rss_feeds_on_search_fields_as_tsvector,
                   algorithm: :concurrently
    end
  end
end
