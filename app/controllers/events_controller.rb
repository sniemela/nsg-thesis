class EventsController < ApplicationController
  before_filter :login_required, :except => [:index, :show, :feed, :recent, :most_watched, :nearby, :upcoming, :like]
  before_filter :admin_required, :only => [:unapproved, :approve]
  add_breadcrumb I18n.t('title.events'), :events_path
  
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

  def like
    @event = Event.find(params[:id])
    @event.increment!(:liked_count, 1)

    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render :status => :ok }
    end
  end

  def new
    add_breadcrumb I18n.t('title.new_event'), :new_event_path    
    @event = Event.new 
    
    @event.categories.build
    @event.showtimes.build
  end
  
  def create
    params[:event][:category_ids] ||= []

    @event = Event.new(params[:event])
    @event.submitter = current_user

    if @event.save
      if @event.submitter.client_id.nil?
        UserMailer.event_sent_to_admin(@event, @event.submitter).deliver
      else
        @event.approve!
        UserMailer.event_published(@event, @event.submitter).deliver
        UserMailer.notice_admin(@event, @event.submitter).deliver
      end

      message = @event.approved? ? I18n.t('notice.event_published') : I18n.t('notice.event_added')

      if params[:event][:picture].blank?
        redirect_to events_path, :flash => { :success => message }
      else
        render :crop
      end
    else
      render :new
    end
  end

  def show
    @event = Event.find(params[:id], :include => :showtimes)
    @event.increment!(:times_watched, 1)
    @comment = @event.comments.build
    add_breadcrumb @event.name, event_path(@event)
  end
  
  def edit
    @event = Event.find(params[:id])
    add_breadcrumb I18n.t('title.edit_event'), :edit_event_path
  end
  
  def update
    @event = Event.find(params[:id], :include => { :galleries => :gallery_resources })
    ids = params[:event][:category_ids]
    params[:event][:category_ids] = (ids || []) + @event.category_ids
    params[:event][:category_ids].uniq!

    if @event.update_attributes!(params[:event])
      if params[:event][:picture].blank?
        redirect_to @event, :flash => { :success => I18n.t('notice.event_updated') }
      else
        render :crop
      end
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    
    redirect_to :back, :flash => { :success => I18n.t('notice.event_deleted') }
  end

  def unapproved
    @events = Event.unapproved
    add_breadcrumb I18n.t('title.unapproved_events'), :unapproved_events_path
  end

  def approve
    @event = Event.find(params[:id])
    @event.approve!
    UserMailer.event_published(@event, @event.submitter).deliver
    redirect_to unapproved_events_path, :flash => { :success => I18n.t('notice.event_approved') }
  end
  
  def my_events
    add_breadcrumb I18n.t('my_links.my_events'), :myevents_path
    @my_events = current_user.all_events.order('created_at DESC')
  end
end
