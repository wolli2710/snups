class ReportsController < ApplicationController
  
  def image
    report = Report.new(:user_id => params[:user_id],
                        :image_id => params[:image_id])
    if report.save
      image = Image.find(params[:image_id])
      image.report_count = image.report_count + 1
      if image.save
        flash[:notice] = "Thank you for reporting this Image!"
      end
    else
      flash[:alert] = "You already reported this Image!"
    end
    redirect_to :back
  end

  def comment
    report = Report.new(:user_id => params[:user_id],
                        :comment_id => params[:comment_id])
    if report.save
      comment = Comment.find(params[:comment_id])
      comment.report_count = comment.report_count + 1
      if comment.save
        flash[:notice] = "Thank you for reporting this Comment!"
      end
    else
       flash[:alert] = "You already reported this Comment!"
    end
    redirect_to :back
  end
end
