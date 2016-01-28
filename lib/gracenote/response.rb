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
      recursive_downcase_keys body["RESPONSES"]["RESPONSE"].reject { |k,v| k == "status" }
    end

    def ok?
      body["RESPONSES"]["RESPONSE"]["status"] =~ /^ok$/i
    end

    def no_match?
      body["RESPONSES"]["RESPONSE"]["status"] == /^no_match$/i
    end

    def error?
      body["RESPONSES"]["RESPONSE"]["status"] == /^error$/i
    end

    def message
      error? && body["RESPONSES"]["MESSAGE"]
    end

    private

    def recursive_downcase_keys(hash)
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
          v
        end
      end
    end
  end
end
