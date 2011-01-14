require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  should belong_to(:image)
  should belong_to(:user)
  should_not belong_to(:rating)

  should have_many(:report)

  should validate_presence_of(:user_id)
  should validate_presence_of(:image_id)
  should validate_presence_of(:body)


  should "be able to create comment" do
    comment = Comment.new(:user_id => 1, :image_id => 1, :body => "test")
    comment.save

    assert comment.valid?, comment.errors.to_s
  end

  should "not be able to create comment without user_id" do
    comment = Comment.new(:image_id => 1, :body => "test")
    comment.save

    assert !comment.valid?, comment.errors.to_s
  end

  should "not be able to create comment without image_id" do
    comment = Comment.new(:user_id => 1, :body => "test")
    comment.save

    assert !comment.valid?, comment.errors.to_s
  end

    should "not be able to create comment without body" do
    comment = Comment.new(:user_id => 1, :image_id => 1)
    comment.save

    assert !comment.valid?, comment.errors.to_s
  end

end
