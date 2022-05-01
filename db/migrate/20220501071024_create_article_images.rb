class CreateArticleImages < ActiveRecord::Migration[6.1]
  def change
    create_table :article_images do |t|
      t.string :filename

      t.timestamps
    end
  end
end
