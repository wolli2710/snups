require 'test_helper'

class MissionTest < ActiveSupport::TestCase

  should have_many(:image)
  should validate_presence_of(:title)
 

  should "be able to create mission" do
    mission = Mission.new(:status => 1, :title => "Test")
    mission.save

    assert mission.valid?, mission.errors.to_s
  end
  
   should "be able to create mission without status" do
    mission = Mission.new(:title => "Test")
    mission.save

    assert mission.valid?, mission.errors.to_s
  end
  
  should "not be able to create mission without title" do
    mission = Mission.new(:status => 1)
    mission.save

    assert !mission.valid?, mission.errors.to_s
  end
end
