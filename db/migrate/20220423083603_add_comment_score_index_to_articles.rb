class AddCommentScoreIndexToArticles < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    add_index :articles, :comment_score, algorithm: :concurrently
  end
end
