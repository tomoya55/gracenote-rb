module Gracenote
  module Request
    module Register
      def register
        response = query("register") do |xml|
          xml.CLIENT client_id
        end

        raise Gracenote::Errors::RequestError, response.message unless response.ok?
        @user_id = response.params["user"]
      end
    end
  end
end
