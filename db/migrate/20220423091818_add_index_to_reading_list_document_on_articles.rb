class AddIndexToReadingListDocumentOnArticles < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    add_index :articles, :reading_list_document, using: "gin", algorithm: :concurrently
  end
end
