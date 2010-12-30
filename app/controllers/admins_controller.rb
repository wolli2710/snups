class AdminsController < ApplicationController
  
  before_filter :check_admin
  
  def index
    @admins = User.where(:admin => true)
  end
  
  def create
    if admin = User.find(:first, :conditions => [ "name = ?", params[:name]])
      
      if admin.admin == false
        admin.admin = true
        
        if admin.save
          flash[:notice] = "Added new Admin!"
        end
        
      else
        flash[:alert] = "User is already an Admin!"
      end   
      
    else
      flash[:alert] = "Username not found!"
    end
    
    redirect_to :back
  end
  
end
