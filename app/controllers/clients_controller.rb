class ClientsController < ApplicationController
  before_filter :login_required
  before_filter :admin_required, :only => :index

  def index
    @clients = Client.all
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(params[:client])

    if @client.save
      redirect_to @client
    else
      render :action => :new
    end
  end
end
