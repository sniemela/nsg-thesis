class AdsController < ApplicationController
  before_filter :login_required
  before_filter :client_required, :except => [:unconfirmed, :confirm, :index]
  before_filter :admin_required, :only => [:unconfirmed, :confirm, :index]
  add_breadcrumb I18n.t('title.ads'), :ads_path

  def index
    @ads = Ad.unscoped.order('created_at desc')
  end

  def my
    @ads = current_user.client.ads.unscoped.order('created_at desc')
    add_breadcrumb I18n.t('my_links.my_ads'), :my_ads_path
  end

  def new
    @ad = Ad.new
    add_breadcrumb I18n.t("my_links.new_ad"), :new_ad_path
  end

  def unconfirmed
    @ads = Ad.unconfirmed
    add_breadcrumb I18n.t('title.unconfirmed_ads'), :unconfirmed_ads_path
  end

  def confirm
    @ad = Ad.find(params[:id])
    @ad.confirm!
    redirect_to unconfirmed_ads_path, :notice => I18n.t('notice.ad_confirmed')
  end

  def create
    ad_days = params[:ad].delete(:ad_days)
    @ad = Ad.new(params[:ad])

    if @ad.valid?
      @ad.end_time = @ad.start_time + ad_days.to_i.days if ad_days
      @ad.client_id = current_user.client_id

      if @ad.save
        redirect_to ads_path, :notice => I18n.t('notice.ad_created')
      else
        render :new
      end
    else
      render :new
    end
  end

  private
    def client_required
      if current_user.client_id.nil?
        redirect_to root_path, :alert => I18n.t('notice.client_required')
        false
      end
    end
end
