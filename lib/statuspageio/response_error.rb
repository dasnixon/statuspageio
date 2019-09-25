module Statuspageio
  class ResponseError < StandardError

    attr_reader :response, :code, :errors

    def initialize(res)
      @response = res.response
      @code     = res.code
      begin
        @errors = parse_errors(res.parsed_response)
      rescue JSON::ParserError
        @errors = [res.response.body]
      end
    end

    def to_s
      "#{code.to_s} #{response.msg}".strip
    end

    private

    def parse_errors(errors)
      return case errors
        when Hash
          errors.collect{|k,v| "#{k}: #{v}"}
        when String
          [errors]
        when Array
          errors
        else
          []
      end
    end
  end
end
