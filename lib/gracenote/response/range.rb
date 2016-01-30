require "gracenote/response/base"

module Gracenote
  class Response
    class Range < Base
      self.attributes = %w[count start end]

      def next
        self["end"].succ
      end
    end
  end
end
