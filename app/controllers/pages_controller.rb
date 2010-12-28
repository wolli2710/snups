class PagesController < ApplicationController
  
  before_filter :get_offset, :only=> [:home, :profile, :favorites]
  
  def home
    @imageCount = Image.count
    @user = User.new
    @images = Image.order("created_at DESC").limit(2).offset(@offset)
    @random_image = "upload/" + Image.all[rand(Image.all.size)].nameHash + "_medium.jpg"
  end
  
  def tutorial
    
  end
  
  def profile
    
    if (@user = User.find(params[:id])) 
      @imageCount = Image.where(:user_id => params[:id].to_i).count
      @images = Image.order("created_at DESC").limit(2).offset(@offset).where(:user_id => params[:id].to_i)
       if (current_user)  
              if (Friendship.where(:user_id => current_user.id, :friend_id => @user.id ).count > 0)
        @is_following = true
       else
        @is_following = false
      end
    end

    else
      redirect_to home_path()
    end
  end
  
  def favorites
    @user = current_user;

    @friend_ids = Friendship.where(:user_id => current_user.id).find(:all, :select => 'friend_id').map(&:friend_id)
    @images = Image.where(:user_id => @friend_ids).order("created_at DESC").limit(2).offset(@offset)
    @imageCount = Image.where(:user_id => @friend_ids).count
  end
  
  def impressum
    
  end
  
  protected
  def get_offset
    if (@offset = params[:offset].to_i)
    else
      @offset = 0
    end
  end
end
