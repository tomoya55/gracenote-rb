module Gracenote
  module Auth
    module Registration
      def register
        query("register", client: client_id) do |response|
          if response.ok?
            response.params["user"]
          else
            raise response.message
          end
        end
      end
    end
  end
end
