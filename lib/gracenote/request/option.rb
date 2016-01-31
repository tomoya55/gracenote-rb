module Gracenote
  module Request
    class Option
      include Helper

      DEFAULT_OPTIONS = {
        "SELECT_EXTENDED" => %w(
          COVER
          REVIEW
          ARTIST_OET
          MOOD
          TEMPO
          ARTIST_BIOGRAPHY
          ARTIST_IMAGE
          CONTENT
          LINK
        ),
        "SELECT_DETAIL" => %w(
          GENRE:3LEVEL
          MOOD:2LEVEL
          TEMPO:3LEVEL
          ARTIST_ORIGIN:4LEVEL
          ARTIST_ERA:2LEVEL
          ARTIST_TYPE:2LEVEL
        )
      }

      def initialize(xml, options = {})
        @xml = xml

        @options = DEFAULT_OPTIONS.merge(options)
      end

      def render
        @options.each { |k, v| render_option(k, v) }
      end

      def render_option(key, value)
        @xml.OPTION {
          @xml.PARAMETER key
          @xml.VALUE wrap_array(value).join(",")
        }
      end
    end
  end
end
