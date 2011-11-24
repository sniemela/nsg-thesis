class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_url, :flash => { :success => I18n.t('notice.signed_in') }
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url,  :flash => { :success => I18n.t('notice.signed_out') }
  end
  
  def signin
    render :layout => false
  end
end
