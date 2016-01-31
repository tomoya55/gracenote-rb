require "gracenote/response/base"

module Gracenote
  class Response
    class Artist < Base
      def name
        self["artist"]
      end

      def origins
        self["artist_origin"]
      end

      def origin
        wrap_array(origins)[0]
      end

      def types
        self["artist_type"]
      end

      def type
        wrap_array(types)[0]
      end

      def eras
        self["artist_era"]
      end

      def era
        wrap_array(eras)[0]
      end

      def to_h
        { "name" => name, "origins" => origins, "types" => types, "eras" => eras }
      end
    end
  end
end
