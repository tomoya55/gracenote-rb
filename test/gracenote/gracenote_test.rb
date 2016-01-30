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

    describe "#search" do
      it "should return albums" do
        stub_request(:post, //).to_return(headers: { 'Content-Type' => 'applicaiton/xml' }, body: <<-XML
<RESPONSES>
  <RESPONSE STATUS="OK">
    <RANGE>
      <COUNT>10228</COUNT>
      <START>1</START>
      <END>10</END>
    </RANGE>
    <ALBUM ORD="1">
      <GN_ID>7286646-4E6F2826F10FDDC14E358050AB130032</GN_ID>
      <ARTIST>The Beatles</ARTIST>
      <TITLE>Abbey Road</TITLE>
      <PKG_LANG>ENG</PKG_LANG>
      <DATE>1969</DATE>
      <GENRE NUM="61364" ID="25332">60&apos;s Rock</GENRE>
      <TRACK_COUNT>17</TRACK_COUNT>
      <TRACK>
        <TRACK_NUM>1</TRACK_NUM>
        <GN_ID>7286647-0D4F7CB2CE2C57A95398CA34EA411CBD</GN_ID>
        <TITLE>Come Together</TITLE>
      </TRACK>
    </ALBUM>
    <ALBUM ORD="2">
      <GN_ID>7317164-1E71D0380B7C84344423FABC8981BC1E</GN_ID>
      <ARTIST>The Beatles</ARTIST>
      <TITLE>Sgt. Pepper&apos;s Lonely Hearts Club Band</TITLE>
      <PKG_LANG>ENG</PKG_LANG>
      <DATE>1967</DATE>
      <GENRE NUM="61364" ID="25332">60&apos;s Rock</GENRE>
      <TRACK_COUNT>13</TRACK_COUNT>
      <TRACK>
        <TRACK_NUM>1</TRACK_NUM>
        <GN_ID>7317165-9AD8800BA4FDB043F7AE8071692CB4BD</GN_ID>
        <TITLE>Sgt. Pepper&apos;s Lonely Hearts Club Band</TITLE>
      </TRACK>
      <TRACK>
        <TRACK_NUM>2</TRACK_NUM>
        <GN_ID>7317166-79D0F85136FE2170885F97716EB779F9</GN_ID>
        <TITLE>With A Little Help From My Friends</TITLE>
      </TRACK>
    </ALBUM>
  </RESPONSE>
</RESPONSES>
        XML
        )

        response = Gracenote::Client.new(client_id: "test", user_id: "test").search(artist: "The Beatles")
        assert { response.ok? == true }
        assert { response.range["count"] == 10228 }
        assert { response.range["start"] == 1 }
        assert { response.range["end"] == 10 }
        assert { response.albums.count == 2 }
        assert { response.albums[0]["title"] == "Abbey Road" }
        assert { response.albums[0].tracks[0]["title"] == "Come Together" }
        assert { response.albums[1]["title"] == "Sgt. Pepper's Lonely Hearts Club Band" }
        assert { response.albums[1].tracks[1]["title"] == "With A Little Help From My Friends" }
      end

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
        assert { response.ok? == true }
        assert { response.params["album"]["gn_id"] == "153857537-C0E89B7AA71C102BD8986ADD02B0DE9C" }
      end
    end
  end
end
