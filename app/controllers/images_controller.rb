class ImagesController < ApplicationController
  
skip_before_filter :verify_authenticity_token, :only => :create 

  def create
    image = Image.new(:user_id => params[:image][:user_id],
                      :mission_id => params[:image][:mission_id])
    
    imageName = Time.now.to_s+params[:image][:user_id]
    image.nameHash = Digest::SHA1.hexdigest(imageName)
    
    mainPath = "#{RAILS_ROOT}/public/images/upload/"
    inputPath = params[:image][:data].path()
    
    output_high = mainPath + image.nameHash.to_s+"_high.jpg"
    output_medium = mainPath + image.nameHash.to_s+"_medium.jpg"
    output_low = mainPath + image.nameHash.to_s+"_low.jpg"
    
    imageData = MiniMagick::Image.open(inputPath)
    image.write  output_high
    
    image.resize "300x200"
    image.write  output_medium
    
    image.resize "100x65"
    image.write output_low
    
    image.save()

  end
end
