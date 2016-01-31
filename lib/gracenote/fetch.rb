module Gracenote
  module Fetch
    def fetch(gn_id:)
      query("album_fetch", auth: auth, lang: lang, country: country) do |xml|
        xml.GN_ID gn_id
      end
    end
  end
end
