class Image < ActiveRecord::Base
  
  include MiniMagick

  before_destroy :delete_image_files
   
	has_many :comment, :dependent => :destroy
	has_many :rating, :dependent => :destroy
  has_many :report, :dependent => :destroy
	belongs_to :mission
	belongs_to :user
  
  attr_accessible :user_id, :mission_id, :nameHash
  
  validates :user_id, :presence => true, :numericality => true
  validates :mission_id, :presence => true, :numericality => true
  validates :nameHash, :presence => true

  def delete_image_files
    File.delete("#{Rails.root}/public/images/upload/#{self.nameHash}_high.jpg")
    File.delete("#{Rails.root}/public/images/upload/#{self.nameHash}_medium.jpg")
    File.delete("#{Rails.root}/public/images/upload/#{self.nameHash}_low.jpg")
  end
end
