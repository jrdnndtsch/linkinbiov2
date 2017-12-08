class AddColumnSelectedToGrams < ActiveRecord::Migration[5.0]
  def change
    add_column :grams, :selected, :boolean, default: false
  end
end
