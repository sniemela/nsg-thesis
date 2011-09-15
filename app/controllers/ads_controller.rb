class AdsController < ApplicationController
  before_filter :login_required
  before_filter :client_required

  def new
    @ad = Ad.new
  end

  private
    def client_required
      if current_user.client_id.nil?
        redirect_to root_path, :alert => 'Client is required to complete this action'
        false
      end
    end
end
