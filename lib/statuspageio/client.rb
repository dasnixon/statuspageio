# frozen_string_literal: true

require 'httparty'
require 'statuspageio/configuration'
require 'statuspageio/response_error'

module Statuspageio
  class Client
    include HTTParty
    base_uri 'https://api.statuspage.io/v1'

    require 'statuspageio/client/incident'
    require 'statuspageio/client/subscriber'

    include Statuspageio::Client::Incident
    include Statuspageio::Client::Subscriber

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
      raise ResponseError, response if response.instance_of?(HTTParty::Response)

      raise StandardError, 'Unknown error'
    end

    def delete(path)
      self.class.handle_response(self.class.delete("#{path}.json", headers: headers))
    end

    def get(path, query = {})
      self.class.handle_response(self.class.get("#{path}.json", query: query, headers: headers))
    end

    def post(path, data = {})
      self.class.handle_response(self.class.post("#{path}.json", body: data.to_json, headers: headers))
    end

    def put(path, data = {})
      self.class.handle_response(self.class.put("#{path}.json", body: data.to_json, headers: headers))
    end

    private

    def symbolize_keys(opts)
      opts.transform_keys do |key|
        key.to_sym
      rescue StandardError
        key
      end
    end

    def headers
      {
        'Authorization' => "OAuth #{api_key}",
        'Content-Type' => 'application/json'
      }
    end
  end
end
