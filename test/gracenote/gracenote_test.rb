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

    describe "#search" do
      it "should return the album info" do
        stub_request(:post, //).to_return(headers: { 'Content-Type' => 'applicaiton/xml' }, body: <<-XML
<RESPONSES>
  <RESPONSE STATUS="OK">
    <ALBUM>
      <GN_ID>153857537-C0E89B7AA71C102BD8986ADD02B0DE9C</GN_ID>
      <ARTIST>Perfume</ARTIST>
      <TITLE>GAME</TITLE>
      <PKG_LANG>JPN</PKG_LANG>
      <DATE>2008</DATE>
      <GENRE NUM="105247" ID="35495">ダンス ＆ クラブ</GENRE>
      <MATCHED_TRACK_NUM>5</MATCHED_TRACK_NUM>
      <TRACK_COUNT>12</TRACK_COUNT>
      <TRACK>
        <TRACK_NUM>5</TRACK_NUM>
        <GN_ID>153857542-F5B1994A6C9EBF79D7FFB02EDF189A1D</GN_ID>
        <TITLE>チョコレイト・ディスコ</TITLE>
      </TRACK>
    </ALBUM>
  </RESPONSE>
</RESPONSES>
        XML
        )

        response = Gracenote::Client.new(client_id: "test", user_id: "test").search(artist: "Perfume", album: "GAME", track: "チョコレイト・ディスコ")
        assert { response.params["album"]["gn_id"] == "153857537-C0E89B7AA71C102BD8986ADD02B0DE9C" }
      end
    end
  end
end
