class AddStoredImageToGrams < ActiveRecord::Migration[5.0]
  def up
    add_attachment :grams, :stored_image
  end

  def down
    remove_attachment :grams, :stored_image
  end
end
