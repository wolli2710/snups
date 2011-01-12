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
        if mission = Mission.find_by_id(params[:mission_id])
          if params[:image]
            status = "SUCCESS"
            handle_upload(user)
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
  
  def handle_upload(user)
    #database---------------------------------------------------#
    image = Image.new(:user_id => user.id,
                      :mission_id => params[:mission_id])
    image_name = Time.now.to_s+params[:username]
    image.nameHash = Digest::SHA1.hexdigest(image_name)
    #-----------------------------------------------------------#
    
    #create images----------------------------------------------#
    input_path = params[:image].path()
    
    main_path = Rails.root.to_s + "/public/images/upload/"
    output_high = main_path + image.nameHash + "_high.jpg"
    output_medium = main_path + image.nameHash + "_medium.jpg"
    output_low = main_path + image.nameHash + "_low.jpg"
    
    uploaded_image = MiniMagick::Image.open(input_path)
    
    uploaded_image.write  output_high
    
    uploaded_image = resize_and_crop_banner(uploaded_image, 300, 150)
    uploaded_image.write output_medium
    
    uploaded_image = resize_and_crop(uploaded_image, 100)
    uploaded_image.write output_low
    
    #store to database-----------------------------------------#
    image.save()
  end
   
  def destroy
    if image = Image.find(:first, :conditions => [ "id = ?", params[:id]])
      
      File.delete("#{Rails.root}/public/images/upload/#{image.nameHash}_high.jpg")
      File.delete("#{Rails.root}/public/images/upload/#{image.nameHash}_medium.jpg")
      File.delete("#{Rails.root}/public/images/upload/#{image.nameHash}_low.jpg")
      
      for comment in Comment.where(:image_id => image.id)
        for report in Report.where(:comment_id => comment.id)
          report.destroy
        end
        comment.destroy
      end
      
      for rating in Rating.where(:image_id => image.id)
        rating.destroy
      end
      
      for report in Report.where(:image_id => image.id)
        report.destroy
      end
    
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
        for report in Report.where(:image_id => image.id)
          report.destroy
        end
        flash[:notice] = "Reports set to zero!"
      else
        flash[:alert] = "Reports could not be set to zero"
      end
    end
    redirect_to :back
  end
  
  protected
  def resize_and_crop(image, size)
    if image[:width] < image[:height]
      shave_off = ((
        image[:height]-
        image[:width])/2).round
        image.shave("0x#{shave_off}")
    elsif image[:width] > image[:height]
      shave_off = ((
        image[:width]-
        image[:height])/2).round
        image.shave("#{shave_off}x0")
    end
    image.resize size
    return image
  end
  
  def resize_and_crop_banner(image, w, h)
    size = w.to_s + "x" + h.to_s
    
    image = resize_and_crop(image, w)
    
    shave_h = ((image[:height]- h)/2).round
    image.shave("0x#{shave_h}")

    return image
  end
end
