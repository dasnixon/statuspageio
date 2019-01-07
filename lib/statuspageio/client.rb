require 'statuspageio/configuration'
require 'statuspageio/request'

module Statuspageio
  class Client
    require 'statuspageio/client/incident'

    include Statuspageio::Request
    include Statuspageio::Client::Incident

    attr_accessor(*Configuration::VALID_OPTIONS_KEYS)

    def initialize(options = {})
      options = Statuspageio.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end
  end
end
