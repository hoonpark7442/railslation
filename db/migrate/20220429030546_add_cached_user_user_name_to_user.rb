class AddCachedUserUserNameToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :cached_user_username, :string
  end
end
