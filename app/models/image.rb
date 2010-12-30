class Image < ActiveRecord::Base
  
  include MiniMagick
   
	has_many :comment
	has_many :rating
  has_many :report
	belongs_to :mission
	belongs_to :user
  
  attr_accessible :user_id, :mission_id, :nameHash
  
  validates :user_id, :presence => true, :numericality => true
  validates :mission_id, :presence => true, :numericality => true
  validates :nameHash, :presence => true
end
