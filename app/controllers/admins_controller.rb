class AdminsController < ApplicationController
  
  before_filter :check_admin
  
  def index
    @users = User.where(:admin => true)
  end
  
  def create
    if user = User.find(:first, :conditions => [ "name = ?", params[:name]])
      
      unless user.admin
        user.admin = true
        
        if user.save
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
  
  def destroy
    if user = User.find(:first, :conditions => [ "id = ?", params[:id]])
      
      unless user == current_user
        user.admin = false
        if user.save
            flash[:notice] = "Removed Admin!"
        end
      else
        flash[:alert] = "You can't degrade yourself!"
      end
      
    else
      flash[:alert] = "User not found!"
    end
    
    redirect_to :back
  end
  
end
