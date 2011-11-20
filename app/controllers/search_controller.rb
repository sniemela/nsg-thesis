class SearchController < ApplicationController
  def index
    @events = []

    if params[:q].blank?
      render :advanced
      return
    end

    if params[:advs].blank?
      @events = Event.search(params[:q])
    else
      with = {}
      conditions = {}
      q = {}

      [:name, :description, :address, :city, :country].each do |column|
        conditions[column] = params[column] unless params[column].blank?
      end

      if !params[:ss1].blank? && !params[:ss2].blank?
        with[:start_time] = Time.parse(params[:ss1])..Time.parse(params[:ss2])
      end

      if !params[:loc].blank? && !params[:distance].blank?
        lat, lng = params[:loc].split(',')

        if lng && lat
          q[:geo] = [to_radians(lat.to_f), to_radians(lng.to_f)]
          with["@geodist"] = 0.0..(params[:distance].to_f * 1000)
        end
      end

      q[:with] = with
      q[:conditions] = conditions

      @events = Event.search(q)
      render :advanced
    end

    add_breadcrumb I18n.t('help.search'), :search_index_path 
  end

  def advanced
    @events = []
  end

  private
    def to_radians(degree)
      degree * Math::PI / 180
    end
end

