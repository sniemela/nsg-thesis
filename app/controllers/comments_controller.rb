class CommentsController < ApplicationController
  before_filter :login_required, :except => [:index, :show]
  
  def index
    @commentable = find_commentable
    @comments = @commentable.comments
  end
  
  def new
    @comment = Comment.new
  end
  
  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(params[:comment])
    
    if @comment.save
      redirect_to @commentable, :notice => 'Thank you for your comment!'
    else
      render :new
    end
  end
  
  def show
    @comment = Comment.find(params[:id])
  end
  
  def edit
    @comment = Comment.find(params[:id])
  end
  
  def update
    @comment = Comments.find(params[:id])
    
    if @comment.update_attributes(params[:comment])
      redirect_to event_url, :notice => 'Your comment has been updated!'
    else
      render :edit
    end
  end
  
  def destroy
    @commentable = find_commentable
    @commentable.destroy
    redirect_to @commentable, :notice => "Comment has been deleted!"
  end
  
  private

  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
