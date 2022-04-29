class AddIndexToPublishedOnArticles < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!
  
  def change
    add_index :articles, :published, algorithm: :concurrently
  end
end
