require "gracenote/response/base"

module Gracenote
  class Response
    class Genre < Base
      self.attributes = %w(id num)

      def name
        self["__content__"]
      end
    end
  end
end
