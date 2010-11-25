class Image < ActiveRecord::Base
	has_many :comment
	has_many :rating
	belongs_to :mission
	belongs_to :user
end
