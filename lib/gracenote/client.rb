require "gracenote/http"
require "gracenote/query_builder"
require "gracenote/errors"
require "gracenote/request/register"
require "gracenote/request/search"
require "gracenote/request/fetch"
require "gracenote/response"

module Gracenote
  class Client
    attr_reader :client_id, :user_id, :lang, :country

    include Http
    include QueryBuilder
    include Request::Register
    include Request::Search
    include Request::Fetch

    def initialize(client_id:, user_id: nil, lang: nil, country: nil)
      @client_id = client_id
      @user_id = user_id
      @lang = lang || "eng"
    end

    def lang=(lang)
      @lang = lang
    end

    def country=(country)
      @country = country
    end

    def short_client_id
      client_id.split("-", 2)[0]
    end

    def auth
      raise "user_id is empty" unless user_id
      { client: client_id, user: user_id }
    end

    def query(cmd, options = {}, &block)
      request = build_query(cmd, options, &block).to_xml
      response = post(request)
      Response.new(response)
    end
  end
end
