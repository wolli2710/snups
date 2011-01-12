class Mission < ActiveRecord::Base
	has_many :image
  
  attr_accessible :title

  validates :title, :presence => true
  validates_uniqueness_of :title
end
