class User < ActiveRecord::Base
  has_many :image
  has_many :comment
 # has_many :follower 
    
  include Gravtastic
  gravtastic
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :password, :password_confirmation, :remember_me
  
  validates :name, :length => {:minimum => 3}
  validates_uniqueness_of :name
end
