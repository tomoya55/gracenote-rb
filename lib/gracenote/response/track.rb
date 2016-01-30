require "gracenote/response/base"

module Gracenote
  class Response
    class Track < Base
      self.attributes = %w(gn_id track_num title)

      def track_num
        self["track_num"].to_i
      end
    end
  end
end
