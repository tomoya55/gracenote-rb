module Gracenote
  module Auth
    module Registration
      def register
        response = query("register") do |xml|
          xml.CLIENT client_id
        end

        raise Gracenote::Errors::RequestError.new(response.message) unless response.ok?
        @user_id = response.params["user"]
      end
    end
  end
end
