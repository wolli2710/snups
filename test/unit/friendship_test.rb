require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  
  should belong_to(:friend)
  should belong_to(:user)
  should_not belong_to(:rating)

  should validate_presence_of(:user_id)
  should validate_presence_of(:friend_id)
end
