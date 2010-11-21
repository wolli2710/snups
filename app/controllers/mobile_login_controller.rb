class MobileLoginController < ApplicationController
  def index
    if user = User.find_by_email(params[:email])
      @check = user.valid_password?(params[:pwd])
    else
      @check = false
    end
  end
end
