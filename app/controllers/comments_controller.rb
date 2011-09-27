class CommentsController < ApplicationController
  before_filter :login_required, :except => [:index, :show]
  
  def index
    @comments = Comment.all
  end
  
  def new
    @comment = Comment.new
  end
  
  def create
    @event = Event.find(params[:event_id])
    @comment = @event.comments.create(params[:comment])
    @comment.user_id = current_user
    
    if @comment.save
      redirect_to event_url(@event), :notice => 'Thank you for your comment!'
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
    @event = Event.find(params[:event_id])
    @comment = @event.comments.find(params[:id])
    @comment.destroy
    redirect_to event_url(@event), :notice => "Comment has been deleted!"
  end
end
