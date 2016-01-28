require "faraday"
require "forwardable"

module Gracenote
  class Response
    extend Forwardable
    attr_reader :response

    def_delegators :@response, :success?

    def initialize(response)
      @response = response
    end

    def body
      response.body
    end

    def params
      body["RESPONSES"]["RESPONSE"].reject { |k,v| k == "status" }.each_with_object({}) do |(k,v), memo|
        memo[k.downcase] = v
      end
    end

    def ok?
      body["RESPONSES"]["RESPONSE"]["status"] == "ok"
    end

    def error?
      body["RESPONSES"]["RESPONSE"]["status"] == "error"
    end

    def message
      error? && body["RESPONSES"]["MESSAGE"]
    end
  end
end
