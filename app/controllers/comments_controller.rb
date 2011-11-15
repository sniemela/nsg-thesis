class CommentsController < ApplicationController
  before_filter :login_required, :except => [:index, :show]
  
  def index
    @commentable = find_commentable
    @comments = @commentable.comments
    @comment = Comment.new
  end
  
  def new
    @commentable = find_commentable
    @comment = Comment.new
  end
  
  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(params[:comment])
    @comment.user_id = current_user.id
    
    if @comment.save
      redirect_to event_comments_path(@commentable), :flash => { :success => I18n.t('notice.comment_added') }
    else
      render :new
    end
  end
  
  def show
    @comment = Comment.find(params[:id])
  end
  
  def edit
    @commentable = find_commentable
    @comment = Comment.find(params[:id])
  end
  
  def update
    @commentable = find_commentable
    @comment = Comment.find(params[:id])
    
    if @comment.update_attributes(params[:comment])
      redirect_to event_comments_path(@commentable), :flash => { :success => I18n.t('notice.comment_updated') }
    else
      render :edit
    end
  end
  
  def destroy
    @commentable = find_commentable
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to event_comments_path(@commentable), :flash => { :success => I18n.t('notice.comment_deleted') }
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
