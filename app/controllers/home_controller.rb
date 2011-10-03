class HomeController < ApplicationController
  def index
    @events = Event.approved.includes(:categories).includes(:showtimes).limit(10).offset(0)
  end
end
