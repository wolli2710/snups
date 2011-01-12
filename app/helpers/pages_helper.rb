module PagesHelper
  
  def calculate_tag_size(args)
    counter = 10 
    @images.each do |i| 
      if i[:mission_id].to_i == args[:image_mission].mission.id 
        if counter < 20 
          counter += 0.3 
        end 
      end 
    end 
    return counter.round.to_s
  end
  
  def get_following(args)
    return Friendship.find(:first, :conditions => { :user_id => current_user.id, :friend_id => args[:user].id } )
  end
end
