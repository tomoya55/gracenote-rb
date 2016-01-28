require "gracenote/http"
require "gracenote/xml"
require "gracenote/response"
require "gracenote/auth/registration"

module Gracenote
  class Client
    attr_reader :client_id

    include Http
    include Xml
    include Auth::Registration

    def initialize(client_id:)
      @client_id = client_id
    end

    def short_client_id
      client_id.split("-", 2)[0]
    end

    def query(cmd, params = {}, options = {})
      q = build_query(cmd, params)
      res = post(xml(q))
      response = Response.new(res)
      block_given? ? yield(response) : response
    end

    private

    def build_query(cmd, params = {})
      {
        queries: { query: params.merge(:@cmd => cmd) }
      }
    end
  end
end
