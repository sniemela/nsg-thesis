module EventsHelper
  def get_city(address)
    address = @event.address
    city = address.split(',', 2).last
    return city
  end

  def set_active_if_controller(controller)
    controller == params[:controller] ? 'active_tab' : nil
  end

  def event_image_width(event, options)
    dimensions = event.picture_geometry(options[:style])
    options[:image_width].to_i - (options[:image_width].to_i - dimensions.width.to_i)
  end

  def event_info_width(event, options)
    dimensions = event.picture_geometry(options[:style])
    options[:info_width].to_i + (options[:image_width].to_i - dimensions.width.to_i)
  end
end
