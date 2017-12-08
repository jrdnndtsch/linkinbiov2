task :update_feed => :environment do

    @instas = Instagram.user_recent_media(@triumph_capital, {:count => 15})
    @instas.first(5).each_with_index do |insta, index|
      index_plus_one = index + 1
      this_insta = Gram.where(id: index_plus_one).first_or_initialize({text: insta.caption.text, image_url: insta.images.standard_resolution.url})
      this_insta.update({text: insta.caption.text, image_url: insta.images.standard_resolution.url})
      this_insta.save
    end 
  #pull in instas for blogs
  @instas.each do |insta|
    image_url = insta.images.standard_resolution.url
    if !Blog.where(gram_photo: image_url).present?
      Blog.create(gram_photo: image_url)
    end
  end   
end