class AddDefaultToGramPublished < ActiveRecord::Migration[5.0]
  def change
    change_column_default :grams, :published, false
  end
end
