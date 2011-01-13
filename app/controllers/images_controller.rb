class ImagesController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => :create 
  before_filter :check_admin, :only=> [:index, :destroy, :edit]
  
  def index
    @reported_images = Image.order("report_count DESC").find(:all, :conditions => "report_count > 0")
  end
  
  def create
    status = "ERROR" 
    if user = User.find_by_name(params[:username])
      if user.valid_password?(params[:password])
        if Mission.find_by_id(params[:mission_id])
          if params[:image]
            status = "SUCCESS"
            image = Image.new(:user_id => user.id,
                              :mission_id => params[:mission_id])
            Image.handle_upload(image, params)
            image.save
          else
            status = "NO IMAGE"
          end
        else
          status = "WRONG MISSION"
        end
      else
        status = "WRONG PASSWORD"
      end
    else
      status = "WRONG USER"
    end
    render :json => {:status => status}
  end

  def destroy
    if image = Image.find(:first, :conditions => [ "id = ?", params[:id]])
      if image.destroy
        flash[:notice] = "Image deleted!"
      else
        flash[:alert] = "Image could not be deleted"
      end
    end
    redirect_to :back
  end

  def edit
    if image = Image.find(:first, :conditions => [ "id = ?", params[:id]])

      image.report_count = 0
      if image.save
        Image.set_report_count(image)
        flash[:notice] = "Reports set to zero!"
      else
        flash[:alert] = "Reports could not be set to zero"
      end
    end
    redirect_to :back
  end
end
