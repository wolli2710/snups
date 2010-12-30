class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :get_random_image
  
  protected
  def check_admin
    if current_user
      unless current_user.admin?
        flash[:alert] = "Permission denied - You are not an admin!"
        redirect_to home_path()
      end
    else
      flash[:alert] = "You have to be logged in!"
      redirect_to home_path()
    end
  end

  def get_random_image
    @random_image = "upload/" + Image.all[rand(Image.all.size)].nameHash + "_medium.jpg"
  end
end
