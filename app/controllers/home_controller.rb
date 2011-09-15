class HomeController < ApplicationController
  def index
    @events = Event.approved
  end
end
