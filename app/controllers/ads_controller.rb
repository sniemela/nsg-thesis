class AdsController < ApplicationController
  before_filter :login_required
  before_filter :client_required

  def index
    @ads = current_user.client.ads
  end

  def new
    @ad = Ad.new
  end

  def create
    ad_days = params[:ad].delete(:ad_days)
    @ad = Ad.new(params[:ad])
    @ad.end_time = @ad.start_time + ad_days.to_i.days if ad_days
    @ad.client_id = current_user.client_id

    if @ad.save
      redirect_to ads_path, :notice => 'Ad has been created and waiting for confirmation'
    else
      render :new
    end
  end

  private
    def client_required
      if current_user.client_id.nil?
        redirect_to root_path, :alert => 'Client is required to complete this action'
        false
      end
    end
end
