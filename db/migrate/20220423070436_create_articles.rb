class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.text :body_markdown
      t.string :cached_tag_list
      t.text :cached_user
      t.string :cached_user_name
      t.bigint :collection_id
      t.integer :comment_score, default: 0
      t.integer :comments_count, default: 0, null: false
      t.string :description
      t.datetime :edited_at
      t.integer :featured_number
      t.integer :hotness_score, default: 0
      t.datetime :last_comment_at, default: "2022-04-23 17:00:00"
      t.integer :nth_published_by_author, default: 0
      t.integer :page_views_count, default: 0
      t.string :password
      t.string :path
      t.text :processed_html
      t.integer :public_reactions_count, default: 0, null: false
      t.boolean :published, default: false
      t.datetime :published_at
      t.integer :reactions_count, default: 0, null: false
      t.tsvector :reading_list_document
      t.integer :score, default: 0
      t.text :slug
      t.string :title
      t.bigint :user_id

      t.timestamps
    end
  end
end
