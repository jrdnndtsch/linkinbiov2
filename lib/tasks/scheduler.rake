task :update_feed => :environment do
  User.all.each do |u| 
    if u.insta_client_token.present? && u.insta_client_id.present?
      u.authenticate_and_import_gram
    end 
  end
end