class Comment < ActiveRecord::Base
	belongs_to :image
	belongs_to :user
  has_many :report

  attr_accessible :user_id, :image_id, :body

  validates :user_id, :presence => true
  validates :image_id, :presence => true
  validates :body, :presence => true
end
