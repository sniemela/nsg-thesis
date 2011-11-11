class ClientsController < ApplicationController
  before_filter :login_required
  before_filter :admin_required, :only => [:index, :confirm, :unconfirmed]
  before_filter :client_not_allowed, :only => [:new, :create]

  def index
    @clients = Client.all
    add_breadcrumb I18n.t('title.clients'), :clients_path    
  end

  def new
    @client = Client.new
    add_breadcrumb I18n.t('my_links.new_client'), :new_client_path
  end

  def show
    @client = Client.find(params[:id], :joins => :user, :select => 'clients.*, users.id as user_id')
    add_breadcrumb I18n.t('title.clients'), :clients_path 
  end

  def confirm
    @client = Client.find(params[:id])
    @client.confirm!
    redirect_to unconfirmed_clients_path
  end

  def unconfirmed
    @clients = Client.unconfirmed
  end

  def create
    @client = Client.new(params[:client])
    @client.client_type = params[:client][:client_type]
    @client.user = current_user

    if @client.save
      redirect_to @client
    else
      render :action => :new
    end
  end

  private
    def client_not_allowed
      unless current_user.client_id.nil?
        redirect_to client_path(current_user.client_id)
        false
      end
    end
end
