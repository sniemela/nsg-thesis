class SearchController < ApplicationController
  def index
    @events = Event.search(params[:q])
    add_breadcrumb I18n.t('help.search'), :search_index_path 
  end
end

