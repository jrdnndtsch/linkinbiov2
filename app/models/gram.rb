class Gram < ApplicationRecord
  belongs_to :user
  scope :published, -> { where( published: true, selected: true ) }
  scope :draft, -> { where( published: false, selected: true ) }
  scope :all_selected, -> { where( selected: true ) }
  scope :most_recent, -> { order('insta_posted_date DESC') }
  scope :least_recent, -> { order('insta_posted_date ASC') }
  validates :slug, presence: true
  validates :slug, uniqueness: true

  
  

  extend FriendlyId
  friendly_id :friendly_slug, use: :slugged

  def to_param
    if post_title.present?
      [id, post_title.parameterize].join("-")
    else
      slug
    end
  end

  def create_slug
    if self.post_title.present?
      self.update(slug: [id, post_title.parameterize].join("-"))
    else
      slug = SecureRandom.hex(10)
      self.update(slug: slug)
    end
  end

  def friendly_slug
    if self.post_title.present?
      [id, post_title.parameterize].join("-")
    else
      slug
    end
  end 

  def should_generate_new_friendly_id?
    post_title_changed?
  end

  self.per_page = 10

  def is_blog_post?
    self.post_type === 'post'
  end
 
end
