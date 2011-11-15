class GalleriesController < ApplicationController
  before_filter :find_event

  def index
  end

  def new
    @gallery = Gallery.new
  end

  private
    def find_event
      @event ||= Event.find(params[:event_id])
      raise AtiveRecord::RecordNotFound unless @event
      @event
    end
end
