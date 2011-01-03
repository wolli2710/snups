class MobileController < ApplicationController
  
  skip_before_filter :verify_authenticity_token, :only => :login

  def login
    status = "ERROR"  
    if user = User.find_by_name(params[:username])
      if user.valid_password?(params[:password])
        status = "SUCCESS"
      end
    end
  render :json => {:status => status}
  end

end
