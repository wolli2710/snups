class ImagesController < ApplicationController
  
  skip_before_filter :verify_authenticity_token, :only => :create 
  before_filter :check_admin, :only=> [:index, :destroy]
  
  def index
    
  end
  
  def create  
    #database---------------------------------------------------#
    image = Image.new(:user_id => params[:image][:user_id],
                      :mission_id => params[:image][:mission_id])
    imageName = Time.now.to_s+params[:image][:user_id]
    image.nameHash = Digest::SHA1.hexdigest(imageName)
    #-----------------------------------------------------------#
    
    #create images----------------------------------------------#
    inputPath = params[:image][:data].path()
    
    mainPath = Rails.root.to_s + "/public/images/upload/"
    output_high = mainPath + image.nameHash + "_high.jpg"
    output_medium = mainPath + image.nameHash + "_medium.jpg"
    output_low = mainPath + image.nameHash + "_low.jpg"
    
    uploadedImage = MiniMagick::Image.open(inputPath)
    
    uploadedImage.write  output_high
    
    uploadedImage = resize_and_crop_banner(uploadedImage, 300, 150)
    uploadedImage.write output_medium
    
    uploadedImage = resize_and_crop(uploadedImage, 100)
    uploadedImage.write output_low
    
    #store to database-----------------------------------------#
    image.save()
  end
   
  def delete
    if image = Image.find(:first, :conditions => [ "id = ?", params[:id]])
      
      File.delete("#{RAILS_ROOT}/public/images/upload/#{image.nameHash}_high.jpg")
      File.delete("#{RAILS_ROOT}/public/images/upload/#{image.nameHash}_medium.jpg")
      File.delete("#{RAILS_ROOT}/public/images/upload/#{image.nameHash}_low.jpg")
      
      image.destroy      
    end
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
