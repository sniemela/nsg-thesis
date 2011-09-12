class ClientsController < ApplicationController
  before_filter :admin_required

  def index
    @clients = Client.all
  end
end
