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
      puts g
      if !Gram.where(original_gram_id: g.id).present?
        created_time = Time.at(g.created_time.to_i)
        self.grams.create(image_url: g.images.standard_resolution.url, insta_posted_date: created_time, original_gram_id: g.id)
      end   
    end
  end

  def authenticate_and_get_user_gram_info
    Instagram.configure do |config|
        config.client_id = self.insta_client_id
        config.access_token = self.insta_client_token
    end

    self.update(insta_username: Instagram.user.username, insta_full_name: Instagram.user.full_name, insta_profile_picture: Instagram.user.profile_picture, insta_bio: Instagram.user.bio, insta_website: Instagram.user.website )
  end
end
