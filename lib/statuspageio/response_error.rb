# frozen_string_literal: true

module Statuspageio
  class ResponseError < StandardError
    attr_accessor :response, :code, :errors

    def initialize(res)
      self.response = res.response
      self.code     = res.code
      begin
        self.errors = parse_errors(res.parsed_response)
      rescue JSON::ParserError
        self.errors = [res.response.body]
      end
    end

    def to_s
      [code.to_s, response.msg, inlined_errors].compact.map(&:strip).join(' ')
    end

    private

    def parse_errors(errors)
      case errors
      when Hash
        errors.collect { |k, v| "#{k}: #{v}" }
      when String
        [errors]
      when Array
        errors
      else
        []
      end
    end

    def inlined_errors
      errors&.join(', ')
    end
  end
end
