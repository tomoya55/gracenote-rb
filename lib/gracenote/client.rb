require "gracenote/http"
require "gracenote/xml"
require "gracenote/search"
require "gracenote/response"
require "gracenote/auth/registration"

module Gracenote
  class Client
    attr_reader :client_id, :user_id, :lang

    include Http
    include Xml
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

    def query(cmd, params = {}, options = {})
      q = build_query(cmd, params, options)
      res = post(xml(q))
      response = Response.new(res)
      block_given? ? yield(response) : response
    end

    private

    def auth
      raise "user_id is empty" unless user_id
      { client: client_id, user: user_id }
    end

    def build_query(cmd, params = {}, options = {})
      request = {}
      request[:lang] = options[:lang] == true ? lang : options[:lang] if options[:lang]
      request[:auth] = options[:auth] == true ? auth : options[:auth] if options[:auth]

      { queries: request.merge(query: params.merge(:@cmd => cmd)) }
    end
  end
end
