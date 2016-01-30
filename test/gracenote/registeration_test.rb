require "test_helper"

module Gracenote
  describe "client" do
    describe "#register" do
      it "should return the userid" do
        stub_request(:post, //).to_return(headers: { 'Content-Type' => 'applicaiton/xml' }, body: <<-XML
<RESPONSES>
  <RESPONSE STATUS="OK">
    <USER>F3180SG7792B09ZPN7-UFC6XA8FV3RQ80K0RO7FURV76GQSDM16</USER>
  </RESPONSE>
</RESPONSES>
        XML
        )
        client = Gracenote::Client.new(client_id: "test")
        response = client.register
        assert { response == "F3180SG7792B09ZPN7-UFC6XA8FV3RQ80K0RO7FURV76GQSDM16" }
        assert { client.user_id == "F3180SG7792B09ZPN7-UFC6XA8FV3RQ80K0RO7FURV76GQSDM16" }
      end
    end
  end
end
