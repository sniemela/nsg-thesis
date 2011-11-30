class HomeController < ApplicationController
  def index
    @events = Event.approved.active.includes(:categories).includes(:showtimes).limit(10).offset(0).order('active_time_start DESC')
  end
end
