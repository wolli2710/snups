class Image < ActiveRecord::Base
	has_many :comment
	has_many :rating
	belongs_to :mission
	belongs_to :user
  
  attr_accessible :user_id, :mission_id, :imageHash
  
  validates :user_id, :presence => true, :numericality => true
  validates :mission_id, :presence => true, :numericality => true
  validates :new_image, :presence => true
end
