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

  def mission
    unless Mission.where(:status => true).count == 0
      random_mission = Mission.where(:status => true)[rand(Mission.where(:status => true).size)]
      status = "SUCCESS"
      mission_title = random_mission.title
      mission_id = random_mission.id
    else
      status = "ERROR"
      mission_title = ""
      mission_id = ""
    end
    render :json => {:status => status, :title => mission_title, :id => mission_id }
  end
  
end
