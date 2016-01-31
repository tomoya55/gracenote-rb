module Gracenote
  class Response
    class Base
      include Helper

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
        values = wrap_array(@response[attr]).map do |value|
          if value.is_a?(Hash) && value.key?("__content__")
            value["__content__"]
          else
            value
          end
        end
        values.size == 1 ? values[0] : values
      end

      def to_h
        @response
      end
    end
  end
end
