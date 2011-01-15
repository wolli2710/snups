require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  should have_many(:friendships)
  should have_many(:friends).through(:friendships)
  should have_many(:inverse_friends).through(:inverse_friendships)

  should have_many(:image)
  should have_many(:comment)
  should have_many(:rating)
  should have_many(:report)
  
  should "be able to create User account" do
    user = User.new(:name => "tester", :email => "tester@gmail.com", :password => "fffffff" , :password_confirmation => "fffffff")
    user.save

    assert user.valid?, user.errors.to_s
  end
  
   should "not be able to create User account without password" do
    user = User.new(:name => "tester", :email => "tester@gmail.com")
    user.save

    assert !user.valid?, user.errors.to_s
  end
  
   should "not be able to create User account without e-mail" do
    user = User.new(:name => "tester", :password => "fffffff" , :password_confirmation => "fffffff")
    user.save

    assert !user.valid?, user.errors.to_s
  end

end
