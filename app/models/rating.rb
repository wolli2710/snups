class Rating < ActiveRecord::Base
	belongs_to :image
	has_one :user
end
