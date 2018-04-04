class AddSlugToGram < ActiveRecord::Migration[5.0]
  def change
    add_column :grams, :slug, :string, unique: true
  end
end
