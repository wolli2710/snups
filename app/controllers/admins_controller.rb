class AdminsController < ApplicationController
  
  before_filter :check_admin
  
  def index
    
  end
  
  private
  def check_admin
    unless current_user.admin?
      flash[:alert] = "You are not an admin!"
      redirect_to home_path()
    end
  end
end
