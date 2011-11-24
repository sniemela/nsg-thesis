class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user

  before_filter :set_locale
  before_filter :set_time_zone

	add_breadcrumb I18n.t('title.home'), :root_path
  def admin_required
    unless current_user && current_user.admin?
      redirect_to root_path, :alert => I18n.t('notice.unauthorized_access')
      false
    end
  end

  def set_locale
    I18n.locale = params[:locale] || :en
  end

  def set_time_zone
    Time.zone = 'Helsinki' if I18n.locale == :fi
  end

  def login_required
    unless current_user
      redirect_to root_path, :alert => I18n.t('notice.sign_in_required')
      false
    end
  end

  def default_url_options
    locale = I18n.locale == :en ? nil : I18n.locale
    { :locale =>  locale }
  end

  private

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end
end
