class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user

  def admin_required
    unless current_user && current_user.admin?
      redirect_to root_path, :alert => 'Unauthorized access'
      false
    end
  end

  def login_required
    unless current_user
      redirect_to root_path, :alert => 'You must log in to complete this action'
      false
    end
  end

  private

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id],
          :joins => 'left join clients on clients.user_id = users.id',
          :select => 'users.*, clients.id as client_id')
    end
  end
end
