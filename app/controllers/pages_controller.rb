class PagesController < ApplicationController
  
  def home
    @images = Image.order("updated_at DESC").limit(10)
  end
  
  def tutorial
    
  end
  
  def profile
    if (@user = User.find(params[:id]))
      @images = Image.where(:user_id => params[:id])
    else
      redirect_to home_path()
    end
  end
  
  def impressum
    
  end
end
