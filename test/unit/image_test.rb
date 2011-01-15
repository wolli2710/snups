require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  
  should have_many(:comment).dependent(:destroy)
  should have_many(:rating).dependent(:destroy)
  should have_many(:report).dependent(:destroy)
  should belong_to(:mission)
  should belong_to(:user)
  
   should "be able to create image" do
    image = Image.new(:user_id => 1, :mission_id => 1, :nameHash => "test1")
    image.save

    assert image.valid?, image.errors.to_s
  end

  should "not be able to create image without user_id" do
    image = Image.new(:mission_id => 1, :nameHash => "test2.jpg")
    image.save

    assert !image.valid?, image.errors.to_s
  end

  should "not be able to create image without mission_id" do
    image = Image.new(:user_id => 1, :nameHash => "test3.jpg")
    image.save

    assert !image.valid?, image.errors.to_s
  end
end
