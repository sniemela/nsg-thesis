class EventsController < ApplicationController
  before_filter :login_required, :except => [:index, :show, :feed, :recent, :most_watched, :nearby, :upcoming]
  before_filter :admin_required, :only => [:unapproved, :approve]

  def index
    @events = Event.approved.recent
  end

  def recent
    @events = Event.approved.recent

    respond_to do |format|
      format.html { render :template => 'events/index' }
      format.js { render :template => 'events/filter_result' }
    end
  end

  def most_watched
    @events = Event.approved.most_watched

    respond_to do |format|
      format.html { render :template => 'events/index' }
      format.js { render :template => 'events/filter_result'  }
    end
  end

  def nearby
    use_ip = !(params[:location].present? && params[:location].split(',').size == 2)
    location = use_ip ? request.env['REMOTE_ADDR'] : params[:location].split(',').map { |l| l.to_f }

    @events = Event.approved.near(location, 20, :units => :km)

    respond_to do |format|
      format.html { render :template => 'events/index' }
      format.js { render :template => 'events/filter_result' }
    end
  end

  def upcoming
    @events = Event.approved.upcoming

    respond_to do |format|
      format.html { render :template => 'events/index' }
      format.js { render :template => 'events/filter_result' }
    end
  end

  def feed
    @events = Event.approved.includes(:categories).includes(:showtimes).limit(50).order('active_time_start DESC')

    respond_to do |wants|
      wants.rss { render :layout => false }
    end
  end
  
  def new
    @event = Event.new 
    
    @event.categories.build
    @event.showtimes.build      
    @event.galleries.build
    @event.galleries[0].gallery_resources.build
  end
  
  def create
    @event = Event.new(params[:event])
    
    @event.submitter = current_user
    
    if @event.save
      if params[:event][:galleries_attributes].blank?
        redirect_to events_path, :notice => 'Event added.'
      else
        render :crop
      end
    else
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
    @event.increment!(:times_watched, 1)
    @comment = @event.comments.build
  end
  
  def edit
    @event = Event.find(params[:id])
    
    if @event.galleries.blank?
      @event.galleries.build
      @event.galleries[0].gallery_resources.build
    end
  end
  
  def update
    @event = Event.find(params[:id])
    
    if @event.update_attributes(params[:event])
      unless params[:event][:galleries_attributes].blank?
        redirect_to events_path, :notice => 'Event updated.'
      end
    else
      render :edit
    end
  end
  
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    
    redirect_to events_url
  end

  def unapproved
    @events = Event.unapproved
  end

  def approve
    @event = Event.find(params[:id])
    @event.approve!
    redirect_to unapproved_events_path, :notice => 'Event approved'
  end
  
  def my_events
    @my_events = current_user.all_events
  end
end
