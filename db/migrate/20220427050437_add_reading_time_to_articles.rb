class AddReadingTimeToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :reading_time, :integer, default: 0
  end
end
