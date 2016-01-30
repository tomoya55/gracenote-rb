require "gracenote/response/base"

module Gracenote
  class Response
    class CoverArt < Base
      self.attributes = %w(type size width height)

      def href
        self["__content__"]
      end

      def width
        self["width"].to_i
      end

      def height
        self["height"].to_i
      end
    end
  end
end
