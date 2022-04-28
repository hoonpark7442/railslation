class AddArticlesCountToUsers < ActiveRecord::Migration[6.1]

  def self.up

    add_column :users, :articles_count, :integer, :null => false, :default => 0

  end

  def self.down

    remove_column :users, :articles_count

  end

end
