module Gracenote
  class Response
    class Base
      def self.attributes=(attrs)
        attrs.each do |attr|
          define_method(attr) do
            self[attr]
          end
        end
      end

      def initialize(response)
        @response = response
      end

      def [](attr)
        @response[attr]
      end

      def to_h
        @response
      end
    end
  end
end
