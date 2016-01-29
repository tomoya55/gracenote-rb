require "faraday"
require "forwardable"
require "gracenote/response/album"

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

    def range
      recursive_downcase_keys body["RESPONSES"]["RESPONSE"]["RANGE"], numerify_values: true
    end

    def params
      recursive_downcase_keys body["RESPONSES"]["RESPONSE"].reject { |k,v| k == "STATUS" }
    end

    def albums
      [*params["album"]].map { |attrs| Album.new(attrs) }
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

    def recursive_downcase_keys(hash, numerify_values: false)
      hash.each_with_object({}) do |(k,v), memo|
        memo[k.downcase] = case v
        when Hash
          recursive_downcase_keys(v)
        when Array
          v.map do |e|
            case e
            when Hash
              recursive_downcase_keys(e)
            else
              e
            end
          end
        else
          if numerify_values && v =~ /^\d+$/
            v.to_i
          else
            v
          end
        end
      end
    end
  end
end
