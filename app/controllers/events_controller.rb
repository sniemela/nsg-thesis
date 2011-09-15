class EventsController < ApplicationController
  before_filter :login_required, :except => [:index, :show]
  
  def index
    @events = Event.all
  end
  
  def new
    @event = Event.new
  end
  
  def create
    @event = Event.new(params[:event])
    
    @event.submitter = current_user
    
    if @event.save
      redirect_to events_url, :notice => 'Event added.'
    else
      render :new
    end
  end
  
  def show
    @event = Event.find(params[:id])
  end
  
  def edit
    @event = Event.find(params[:id])
  end
  
  def update
    @event = Event.find(params[:id])
    
    if @event.update_attributes(params[:event])
      redirect_to events_url, :notice => 'Event updated.'
    else
      render :edit
    end
  end
  
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    
    redirect_to events_url
  end
  
  def my_events
    @my_events = current_user.events
  end
end
