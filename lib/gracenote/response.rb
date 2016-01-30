require "faraday"
require "forwardable"
require "gracenote/response/album"

module Gracenote
  class Response
    extend Forwardable
    include Helper
    attr_reader :response

    def_delegators :@response, :success?

    def initialize(response)
      @response = response
    end

    def body
      response.body
    end

    def range
      recursive_downcase_keys body["RESPONSES"]["RESPONSE"]["RANGE"], numerify_values: true
    end

    def params
      recursive_downcase_keys params_body
    end

    def albums
      wrap_array(params["album"]).map { |attrs| Album.new(attrs) }
    end

    def album
      albums[0]
    end

    def ok?
      body["RESPONSES"]["RESPONSE"]["STATUS"] == "OK"
    end

    def no_match?
      body["RESPONSES"]["RESPONSE"]["STATUS"] == "NO_MATCH"
    end

    def error?
      body["RESPONSES"]["RESPONSE"]["STATUS"] == "ERROR"
    end

    def message
      error? && body["RESPONSES"]["MESSAGE"]
    end

    private

    def params_body
      body["RESPONSES"]["RESPONSE"].reject { |k,v| k == "STATUS" }
    end
  end
end
