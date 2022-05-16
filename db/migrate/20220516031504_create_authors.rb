class CreateAuthors < ActiveRecord::Migration[6.1]
  def change
    create_table :authors do |t|
      t.string :name
      t.string :description
      t.integer :author_type, default: 1, null: false
      t.string :website_url, null: false
      t.string :feed_url, null: false
      t.integer :nationality, default: 1, null: false
      t.datetime :feed_fetched_at, default: "2022-04-23 17:00:00"

      t.timestamps
    end
  end
end
