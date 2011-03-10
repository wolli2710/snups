class ImagesController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => :create 
  before_filter :check_admin, :only=> [:index, :destroy, :edit]  
  
  def index
    @reported_images = Image.order("report_count DESC").find(:all, :conditions => "report_count > 0")
  end
  
  
  def create   

    if User.check_user_and_password(params)
      image = Image.new(params[:image])
      if image.save()
        render :json => {:status => "SUCCESS"}
      else
        render :json => {:status => "ERROR"}
      end
    end
    
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
