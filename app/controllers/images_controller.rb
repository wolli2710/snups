class ImagesController < ApplicationController
  
  skip_before_filter :verify_authenticity_token, :only => :create 
  
  def create  
    #database---------------------------------------------------#
    image = Image.new(:user_id => params[:image][:user_id],
                      :mission_id => params[:image][:mission_id])
    imageName = Time.now.to_s+params[:image][:user_id]
    image.nameHash = Digest::SHA1.hexdigest(imageName)
    #-----------------------------------------------------------#
    
    #create images----------------------------------------------#
    inputPath = params[:image][:data].path()
    
    mainPath = "D:/snups/public/images/"
    output_high = mainPath + image.nameHash + "_high.jpg"
    output_medium = mainPath + image.nameHash + "_medium.jpg"
    output_low = mainPath + image.nameHash + "_low.jpg"
    
    imageName = MiniMagick::Image.open(inputPath)
    
    imageName.write  output_high
    
    imageName.resize "300x200"
    imageName.write output_medium
    
    imageName.resize "100x65"
    imageName.write output_low
    
    #store to database-----------------------------------------#
    image.save()
  end
end
