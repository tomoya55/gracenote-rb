module Gracenote
  module Auth
    module Registration
      def register
        response = query("register") do |xml|
          xml.CLIENT client_id
        end
        if response.ok?
          @user_id = response.params["user"]
        else
          raise response.message
        end
      end
    end
  end
end
