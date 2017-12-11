class Gram < ApplicationRecord
  belongs_to :user
  scope :published, -> { where( published: true, selected: true ) }
  scope :draft, -> { where( published: false, selected: true ) }
  scope :all_selected, -> { where( selected: true ) }
end
