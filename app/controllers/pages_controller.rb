class PagesController < ApplicationController

  before_filter :get_vars, :only=> [:home, :gallery]
  
  def home
    @images = Image.order("updated_at DESC").limit(10)
  end
  
  def tutorial
    
  end
  
  def gallery
    @images = Image.all
  end
  
  def impressum
    
  end
  
  def get_vars
    @users = User.all
    @missions = Mission.all
  end
  
end
