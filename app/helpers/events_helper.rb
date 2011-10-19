module EventsHelper
  def get_city(address)
    address = @event.address
    city = address.split(',', 2).last
    return city
  end
end
