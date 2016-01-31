require "gracenote/http"
require "gracenote/query_builder"
require "gracenote/errors"
require "gracenote/search"
require "gracenote/response"
require "gracenote/auth/registration"

module Gracenote
  class Client
    attr_reader :client_id, :user_id, :lang

    include Http
    include QueryBuilder
    include Auth::Registration
    include Search

    def initialize(client_id:, user_id: nil, lang: nil)
      @client_id = client_id
      @user_id = user_id
      @lang = lang || "eng"
    end

    def lang=(lang)
      @lang = lang
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
