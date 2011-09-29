class HomeController < ApplicationController
  def index
    @events = Event.approved.includes(:categories).limit(10).offset(0)
  end
end
