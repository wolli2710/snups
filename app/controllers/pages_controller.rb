class PagesController < ApplicationController
  
  def home

      @images = Image.order("updated_at DESC").limit(10)
      @missions = Mission.all


  end
  
  def tutorial
    
  end
  
  def profile
    if (@user = User.find_by_name(params[:name]))
    else
      redirect_to home_path()
    end
  end
  
  def impressum
    
  end  
end
