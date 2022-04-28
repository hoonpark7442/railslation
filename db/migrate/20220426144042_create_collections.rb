class CreateCollections < ActiveRecord::Migration[6.1]
  def change
    create_table :collections do |t|
      t.string :slug
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :collections, %i[slug user_id], unique: true
  end
end
