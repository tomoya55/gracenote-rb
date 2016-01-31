require "gracenote/response/base"

module Gracenote
  class Response
    class Track < Base
      self.attributes = %w(gn_id track_num title)

      def track_num
        self["track_num"].to_i
      end

      def moods
        self["mood"]
      end

      def mood
        wrap_array(moods)[0]
      end

      def tempos
        self["tempo"]
      end

      def tempo
        wrap_array(tempos)[0]
      end
    end
  end
end
