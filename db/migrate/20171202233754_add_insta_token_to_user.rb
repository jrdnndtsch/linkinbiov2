class AddInstaTokenToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :insta_client_id, :string
    add_column :users, :insta_client_token, :string
  end
end
