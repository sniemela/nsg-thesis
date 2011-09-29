class SearchController < ApplicationController
  def index
    @events = Event.search(params[:q])
  end
end

