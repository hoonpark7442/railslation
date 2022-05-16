class AddUnniqueIndextoAuthors < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    add_index :authors, :feed_url, unique: true, algorithm: :concurrently
    add_index :authors, :website_url, unique: true, algorithm: :concurrently
  end
end
