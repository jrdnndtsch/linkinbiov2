class AddSlugToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :slug, :string, unique: true
  end
end
