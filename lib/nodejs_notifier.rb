require 'net/http'

class NodejsNotifier
  HOST = 'localhost'
  PORT = 1337

  def self.notify(url, params)
    request = Net::HTTP::Post.new(url, 'Content-Type' => 'application/json')
    request.body = params

    begin
      Net::HTTP.new(HOST, PORT).start { |http| http.request(request) }
    rescue
      Rails.logger.debug("Could not complete the request to the node.js server")
    end
  end
end
