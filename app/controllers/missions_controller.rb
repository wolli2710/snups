class MissionsController < ApplicationController
  
  
  def new
    @mission = Mission.new
  end
  
  def create
    mission = Mission.new(params[:mission])
    if mission.save
      flash[:notice] = "Thank you for suggesting a new Mission!"
    else
      flash[:alert] = "This Mission is alrady in our Database!"
    end
    
    redirect_to :action => 'new'
  end
  
end
