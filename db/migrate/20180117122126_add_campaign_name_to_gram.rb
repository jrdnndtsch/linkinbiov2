class AddCampaignNameToGram < ActiveRecord::Migration[5.0]
  def change
    add_column :grams, :campaign_name, :string
  end
end
