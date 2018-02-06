class AddValuesToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :insta_username, :string
    add_column :users, :insta_full_name, :string
    add_column :users, :insta_profile_picture, :string
    add_column :users, :insta_bio, :string
    add_column :users, :insta_website, :string
  end
end
