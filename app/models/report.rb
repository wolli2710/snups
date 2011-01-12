class Report < ActiveRecord::Base
  belongs_to :image
  belongs_to :comment
  belongs_to :user

  attr_accessible :user_id, :comment_id, :image_id

  validates :user_id, :presence => true
  validates_uniqueness_of :user_id, :scope => [:image_id, :comment_id]
end
