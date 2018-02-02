class AddOriginalGramIdToGram < ActiveRecord::Migration[5.0]
  def change
    add_column :grams, :original_gram_id, :string
  end
end
