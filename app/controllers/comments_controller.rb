class CommentsController < ApplicationController
  
  before_filter :check_admin, :only=> [:index]
  
  def index
    @comments = Comment.order("report_count DESC").find(:all, :conditions => "report_count > 0")
  end
  
  def create
    comment = Comment.new(:user_id => params[:user_id],
                      :image_id => params[:image_id],
                      :body => params[:body])
    comment.save
    redirect_to :back
  end
  
  def destroy
    if comment = Comment.find(:first, :conditions => [ "id = ?", params[:id]])
      
      if comment.destroy
        
        for report in Report.where(:comment_id => comment.id)
          report.destroy
        end
        
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
