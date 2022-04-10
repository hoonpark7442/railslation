class CreateSocialAuths < ActiveRecord::Migration[6.1]
  def change
    create_table :social_auths do |t|
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :email
      t.string :image
      t.references :user, null: false, foreign_key: false

      t.timestamps
    end
  end
end
