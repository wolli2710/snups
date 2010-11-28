class PagesController < ApplicationController

  
  def home
    @users = User.all
    @missions = Mission.all
    @images = Image.all
  end
  
  def tutorial
    
  end
  
  def gallery
    
  end
  
  def impressum
    
  end
  
end
