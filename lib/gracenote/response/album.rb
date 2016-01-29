module Gracenote
  class Response
    class Album
      attr_reader :response

      def initialize(response)
        @response = response
      end

      def [](attr)
        response[attr]
      end

      def tracks
        case response["track"]
        when Array
          response["track"]
        when Hash
          [response["track"]]
        end
      end
    end
  end
end
