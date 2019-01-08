require 'httparty'
require 'statuspageio/configuration'
require 'statuspageio/response_error'

module Statuspageio
  class Client
    include HTTParty
    base_uri 'api.statuspage.io/v1'

    require 'statuspageio/client/incident'
    include Statuspageio::Client::Incident

    attr_accessor(*Configuration::VALID_OPTIONS_KEYS)

    def initialize(options = {})
      options = Statuspageio.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    def self.handle_response(response)
      if response.success?
        JSON.parse(response.body)
      else
        bad_response(response)
      end
    end

    def self.bad_response(response)
      if response.class == HTTParty::Response
        raise ResponseError, response
      end
      raise StandardError, "Unknown error"
    end

    def delete(path)
      self.class.handle_response(self.class.delete("#{path}.json", headers: headers))
    end

    def get(path)
      self.class.handle_response(self.class.get("#{path}.json", headers: headers))
    end

    def post(path, data = {})
      self.class.handle_response(self.class.post("#{path}.json", data, headers: headers))
    end

    def put(path, data = {})
      self.class.handle_response(self.class.put("#{path}.json", data, headers: headers))
    end

    private

    def headers
      { 'Authorization' => "OAuth #{self.api_key}" }
    end
  end
end
