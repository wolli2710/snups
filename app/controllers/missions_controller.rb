class MissionsController < ApplicationController
  
  
  def new
    @mission = Mission.new
  end
  
  def create
    mission = Mission.new(params[:mission])
    mission.save
    
    redirect_to home_path
  end
  
end
