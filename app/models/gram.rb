class Gram < ApplicationRecord
  belongs_to :user
  scope :published, -> { where( published: true, selected: true ) }
  scope :draft, -> { where( published: false, selected: true ) }
  scope :all_selected, -> { where( selected: true ) }
  scope :most_recent, -> { order('insta_posted_date DESC') }
  scope :least_recent, -> { order('insta_posted_date ASC') }

  self.per_page = 10
 
end
