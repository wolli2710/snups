class ImagesController < ApplicationController
  
  def new
    
  end

def create

i=0
inputPath = "lena.jpg"
mainPath = "D:/snups/public/images/"
output = mainPath + "lena"+i.to_s+".jpg"
outputSmall = mainPath + "lena"+i.to_s+"_small.jpg"

image = MiniMagick::Image.open("D:/snups/public/images/" + inputPath)
image.resize "100x100"
image.write  outputSmall

image.resize "400x400"
image.write output

@images = Image.all
@missions = Mission.all

  end
end
