class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :get_random_image

  def get_random_image
    @random_image = "upload/" + Image.all[rand(Image.all.size)].nameHash + "_medium.jpg"
  end
end
