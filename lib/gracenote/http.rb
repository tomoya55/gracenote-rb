require "faraday"
require "faraday_middleware"

module Gracenote
  module Http

    def post(body)
      agent.post do |req|
        req.url path
        req.headers["Content-Type"] = "application/xml"
        req.body = body
      end
    end

    def host
      "https://c#{short_client_id}.web.cddbp.net"
    end

    def path
      "/webapi/xml/1.0/"
    end

    def agent
      @agent ||= begin
        Faraday.new(url: host) do |conn|
          conn.response :xml,  :content_type => /\bxml$/
          conn.adapter Faraday.default_adapter
        end
      end
    end
  end
end
