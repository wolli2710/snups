class MobileController < ApplicationController
  
  skip_before_filter :verify_authenticity_token, :only => :create

  def create
    status = "ERROR"
    message = "Login failed"
        
    if user = User.find_by_email(params[:username])
      if user.valid_password?(params[:password])
        status = "SUCCESS"
        message = "Login successful"
      end
    end
    
    xml = Builder::XmlMarkup.new
    xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
    render :xml => xml.login { |b| b.status(status); b.message(message) }
  end

end
