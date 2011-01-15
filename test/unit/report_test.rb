require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  
  should belong_to(:image)
  should belong_to(:user)
  should belong_to(:comment)

  should validate_presence_of(:user_id)
  
  should "be able to create Report for image" do
    report = Report.new(:user_id => 1, :image_id => 1)
    report.save

    assert report.valid?, report.errors.to_s
  end
  
 should "be able to create Report for comment" do
    report = Report.new(:user_id => 1, :comment_id => 1)
    report.save

    assert report.valid?, report.errors.to_s
  end
end
