class GalleriesController < ApplicationController
  before_filter :find_event

  def index
    @galleries = @event.galleries.includes(:gallery_resources)
  end

  def new
    @gallery = Gallery.new
    3.times do
      @gallery.gallery_resources.build
    end
  end

  def create
    @gallery = @event.galleries.build(params[:gallery])

    if @gallery.save
      redirect_to event_galleries_path(@event), :flash => { :success => I18n.t('notice.gallery_created') }
    else
      render :new
    end
  end

  def show
    @gallery = @event.galleries.find(params[:id])
  end

  private
    def find_event
      @event ||= Event.find(params[:event_id])
      raise AtiveRecord::RecordNotFound unless @event
      @event
    end
end
