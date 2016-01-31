require "gracenote/response/base"
require "gracenote/response/artist"
require "gracenote/response/track"
require "gracenote/response/cover_art"

module Gracenote
  class Response
    class Album < Base
      self.attributes = %w(
        gn_id
        pkg_lang
        title
        date
        matched_track_num
        track_count
      )

      def artist
        Artist.new(self)
      end

      def track_count
        self["track_count"].to_i
      end

      def tracks
        wrap_array(self["track"]).map do |track_attrs|
          Track.new(track_attrs)
        end
      end

      def track
        tracks[0]
      end

      def genres
        self["genre"]
      end

      def genre
        wrap_array(genres)[0]
      end

      def cover_art
        url = @response["url"]
        CoverArt.new(url) if url && url["type"] == "COVERART"
      end
    end
  end
end
