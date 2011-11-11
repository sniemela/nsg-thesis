module EventsHelper
  def get_city(address)
    address = @event.address
    city = address.split(',', 2).last
    return city
  end

  def set_active_if_controller(controller)
    controller == params[:controller] ? 'active_tab' : nil
  end
end
