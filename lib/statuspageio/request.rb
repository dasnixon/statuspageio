require 'httparty'

module Statuspageio
  module Request
    include HTTParty
    base_uri 'api.statuspage.io/v1'

    def delete(path, data = {})
      self.class.delete("#{path}.json", data, headers: headers)
    end

    def get(path, data = {})
      self.class.get("#{path}.json", data, headers: headers)
    end

    def post(path, data = {})
      self.class.post("#{path}.json", data, headers: headers)
    end

    def put(path, data = {})
      self.class.put("#{path}.json", data, headers: headers)
    end

    private

    def headers
      { Authorization: "OAuth #{self.api_key}" }
    end
  end
end
