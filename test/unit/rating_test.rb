require 'test_helper'

class RatingTest < ActiveSupport::TestCase
  should belong_to(:image)
  should belong_to(:user)

  should validate_presence_of(:user_id)
  should validate_presence_of(:image_id)

  should "be able to create Rating" do
    rating = Rating.new(:user_id => 1, :image_id => 1)
    rating.save

    assert rating.valid?, rating.errors.to_s
  end
  
  should "not be able to create Rating without user_id" do
    rating = Rating.new( :image_id => 1)
    rating.save

    assert !rating.valid?, rating.errors.to_s
  end

  should "not be able to create Rating without image_id" do
    rating = Rating.new(:user_id => 1)
    rating.save

    assert !rating.valid?, rating.errors.to_s
  end

end
