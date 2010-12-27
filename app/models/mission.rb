class Mission < ActiveRecord::Base
	has_many :image
  
   attr_accessible :title
end
