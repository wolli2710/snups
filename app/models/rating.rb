class Rating < ActiveRecord::Base
  belongs_to :image
  belongs_to :user

  attr_accessible :user_id, :image_id

  validates :user_id, :presence => true
  validates :image_id, :presence => true
  validates_uniqueness_of :user_id, :scope => :image_id
end
