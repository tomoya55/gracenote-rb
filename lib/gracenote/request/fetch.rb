require "gracenote/request/option"

module Gracenote
  module Request
    module Fetch
      def fetch(gn_id:)
        query("album_fetch", auth: auth, lang: lang, country: country) do |xml|
          xml.GN_ID gn_id
          Option.new(xml).render
        end
      end
    end
  end
end
