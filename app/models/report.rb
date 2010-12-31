class Report < ActiveRecord::Base
  belongs_to :image
  belongs_to :comment
  belongs_to :user
  
  validates_uniqueness_of :user_id, :scope => [:image_id, :comment_id]
end