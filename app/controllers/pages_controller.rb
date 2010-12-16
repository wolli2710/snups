class PagesController < ApplicationController
  
  before_filter :get_offset, :only=> [:home, :profile]
  
  def home
    @imageCount = Image.count
    @user = User.new
    @images = Image.order("updated_at DESC").limit(2).offset(@offset)
  end
  
  def tutorial
    
  end
  
  def profile
    if (@user = User.find(params[:id]))
      @imageCount = Image.where(:user_id => params[:id].to_i).count
      @images = Image.order("updated_at DESC").limit(2).offset(@offset).where(:user_id => params[:id].to_i)
    else
      redirect_to home_path()
    end
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
