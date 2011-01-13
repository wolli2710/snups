class MissionsController < ApplicationController
  
  before_filter :check_admin, :only=> [:index, :destroy, :edit]
  
  def index
    @missions = Mission.where(:status => false)
    @approved_missions = Mission.where(:status => true)
  end
  
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
  
  def destroy
    if mission = Mission.find(:first, :conditions => [ "id = ?", params[:id]])
      
      if mission.destroy
        flash[:notice] = "Mission deleted!"
      else
        flash[:alert] = "Mission could not be deleted"
      end
      
    else
      flash[:alert] = "Mission not found!"
    end
    
    redirect_to :back
  end
  
  def edit
    if mission = Mission.find(:first, :conditions => [ "id = ?", params[:id]])
      
      mission.status = true
      if mission.save
        flash[:notice] = "Mission approved!"
      else
        flash[:alert] = "Mission could not be approved"
      end
      
    else
      flash[:alert] = "Mission not found!"
    end
    
    redirect_to :back
  end
  
end
