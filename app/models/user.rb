class User < ActiveRecord::Base
  
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  has_many :image
  has_many :comment
  has_many :rating
  has_many :report

    
  include Gravtastic
  gravtastic
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :password, :password_confirmation, :remember_me, :about
  
  validates :name, :length => {:minimum => 3}
  validates_uniqueness_of :name

  def self.check_user_and_password(params)
    User.find(params[:image][:user_id]).valid_password?(params[:image][:password])
  end
end
