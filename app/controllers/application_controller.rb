class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user

  before_filter :set_locale

  def admin_required
    unless current_user && current_user.admin?
      redirect_to root_path, :alert => 'Unauthorized access'
      false
    end
  end

  def set_locale
    I18n.locale = params[:locale] || :en
  end

  def login_required
    unless current_user
      redirect_to root_path, :alert => 'You must log in to complete this action'
      false
    end
  end

  def default_url_options
    { :locale => I18n.locale }
  end

  private

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end
end
