class GalleriesController < ApplicationController
  before_filter :find_event

  def index
  end

  private
    def find_event
      @event = Event.find(params[:event_id])
      raise ActiveRecord::RecordNotFound unless @event
    end
end
