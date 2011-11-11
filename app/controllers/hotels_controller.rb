class HotelsController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
  end
end
