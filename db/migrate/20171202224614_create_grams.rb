class CreateGrams < ActiveRecord::Migration[5.0]
  def change
    create_table :grams do |t|
      t.string :image_url
      t.string :link
      t.text :blog_text
      t.string :post_type
      t.boolean :published
      t.datetime :insta_posted_date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
