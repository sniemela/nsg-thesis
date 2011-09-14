class ClientsController < ApplicationController
  before_filter :login_required
  before_filter :admin_required, :only => :index

  def index
    @clients = Client.all
  end

  def new
    @client = Client.new
  end

  def show
    @client = Client.find(params[:id], :joins => :user, :select => 'clients.*, users.id as user_id')
  end

  def create
    @client = Client.new(params[:client])
    @client.client_type_id = params[:client][:client_type_id].to_i
    @client.user = current_user

    if @client.save
      redirect_to @client
    else
      render :action => :new
    end
  end
end
