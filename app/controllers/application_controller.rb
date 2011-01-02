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
    unless Image.count == 0
      @random_image = "upload/" + Image.all[rand(Image.all.size)].nameHash + "_medium.jpg"
    else
      @random_image = "logo.png"
    end
  end
end
