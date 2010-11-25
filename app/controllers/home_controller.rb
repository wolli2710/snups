class HomeController < ApplicationController
  
 # before_filter :authenticate_user!, :except => [:index]
  
  def index
    @users = User.all
  end
  
  def settings
  end
end
