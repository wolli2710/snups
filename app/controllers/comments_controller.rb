class CommentsController < ApplicationController
  
  before_filter :check_admin, :only=> [:index]
  
  def index
    
  end
  
  def create
    comment = Comment.new(:user_id => params[:user_id],
                      :image_id => params[:image_id],
                      :body => params[:body])
    comment.save
    redirect_to :back
  end
  
end
