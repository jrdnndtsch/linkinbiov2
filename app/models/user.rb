class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :grams   

  
  require "instagram"
  def authenticate_and_import_gram
    Instagram.configure do |config|
        config.client_id = self.insta_client_id
        config.access_token = self.insta_client_token
    end
    grams = Instagram.user_recent_media(@jrdnndtsch, {:count => 20})
    grams.each do |g|
      if !Gram.where(image_url: g.images.standard_resolution.url).present?
        created_time = Time.at(g.created_time.to_i)
        self.grams.create(image_url: g.images.standard_resolution.url, insta_posted_date: created_time)
      end   
    end
  end
end
