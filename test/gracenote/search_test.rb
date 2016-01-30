require "test_helper"

module Gracenote
  describe "#search" do
    describe "with mode" do
      it "should send mode" do
        client = Gracenote::Client.new(client_id: "test", user_id: "test")
        allow(client).to receive(:query).with("album_search", hash_including(mode: "SINGLE_BEST_COVER"), a_kind_of(Hash))
        client.search(album: "The Bends", mode: "SINGLE_BEST_COVER")
      end
    end
  end
end
