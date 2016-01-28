require "test_helper"

module Gracenote
  describe "client" do
    describe "#register" do
      it "should return the userid" do
        stub_request(:post, //).to_return_xml(
          { responses: {
              response: {
                :@status => "ok",
                user: {
                  content!: "F3180SG7792B09ZPN7-UFC6XA8FV3RQ80K0RO7FURV76GQSDM16"
                }
              }
            }
          }
        )
        assert { Gracenote::Client.new(client_id: "test").register == "F3180SG7792B09ZPN7-UFC6XA8FV3RQ80K0RO7FURV76GQSDM16" }
      end
    end
  end
end
