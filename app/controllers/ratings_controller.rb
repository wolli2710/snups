class RatingsController < ApplicationController
  
  
  def up
    rating = Rating.new(:user_id => params[:user_id],
                        :image_id => params[:image_id])
    if rating.save
      image = Image.find(params[:image_id])
      image.pos = image.pos + 1
      image.save
    else
       flash[:notice] = "Sie haben bereits gevotet!"
    end
    
    redirect_to :back
  end
  
  def down
    rating = Rating.new(:user_id => params[:user_id],
                        :image_id => params[:image_id])
    if rating.save
      image = Image.find(params[:image_id])
      image.neg = image.neg + 1
      image.save
    else
       flash[:notice] = "Sie haben bereits gevotet!"
    end
    redirect_to :back
  end
end
