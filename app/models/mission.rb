class Mission < ActiveRecord::Base
	has_many :image
  
  attr_accessible :title
   
  validates_uniqueness_of :title
end
