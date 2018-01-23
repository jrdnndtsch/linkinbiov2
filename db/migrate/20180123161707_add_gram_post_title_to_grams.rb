class AddGramPostTitleToGrams < ActiveRecord::Migration[5.0]
  def change
    add_column :grams, :post_title, :string
  end
end
