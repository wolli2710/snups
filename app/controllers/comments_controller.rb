class CommentsController < ApplicationController
  
  before_filter :check_admin, :only=> [:index]
  
  def index
    @comments = Comment.where( 'report_count >= ?', 1 )
  end
  
  def create
    comment = Comment.new(:user_id => params[:user_id],
                      :image_id => params[:image_id],
                      :body => params[:body])
    comment.save
    redirect_to :back
  end
  
  def destroy
   if comment = Comment.find(params[:id])
     
      if comment.destroy
        flash[:notice] = "Comment deleted!"
      else
        flash[:alert] = "Comment could not be deleted"
      end
      
    else
      flash[:alert] = "Comment could not be found!"
    end
    
    redirect_to :back

  end
 end
