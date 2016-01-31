require "gracenote/request/option"

module Gracenote
  module Request
    module Search
      # @params mode [String] 'SINGLE_BEST' or 'SINGLE_BEST_COVER'
      # @params range [Hash] { start: 1, end: 10 }
      #
      def search(artist: nil, album: nil, track: nil, mode: nil, range: nil)
        query("album_search", auth: auth, lang: lang, country: country) do |xml|
          xml.MODE { xml.text mode } if mode
          if range
            xml.RANGE {
              xml.START range[:start]
              xml.END range[:end] if range[:end]
            }
          end
          xml.TEXT(TYPE: "ARTIST") { xml.text artist } if artist
          xml.TEXT(TYPE: "ALBUM_TITLE") { xml.text album } if album
          xml.TEXT(TYPE: "TRACK_TITLE") { xml.text track } if track

          options = {}
          options = { "PREFER_XID" => "applealbumid" } if mode == "SINGLE_BEST"
          Option.new(xml, options).render
        end
      end
    end
  end
end
