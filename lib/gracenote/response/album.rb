require "gracenote/response/base"
require "gracenote/response/genre"
require "gracenote/response/track"

module Gracenote
  class Response
    class Album < Base
      include Helper

      self.attributes = %w[
        gn_id
        artist
        pkg_lang
        title
        date
        matched_track_num
        track_count
      ]

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

      def genre
        Genre.new(self["genre"])
      end
    end
  end
end
