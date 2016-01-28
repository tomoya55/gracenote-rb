module Gracenote
  module Search
    # @params mode [String] 'SINGLE_BEST' or 'SINGLE_BEST_COVER'
    def search(artist: nil, album: nil, track: nil, mode: nil)
      params = {}
      params[:mode] = { mode: mode } if mode
      params[:text] = { :@TYPE => 'ARTIST', :content! => artist } if artist
      params[:text] = { :@TYPE => 'ALBUM_TITLE', :content! => album } if album
      params[:text] = { :@TYPE => 'TRACK_TITLE', :content! => track } if track

      query("album_search", params, auth: true, lang: true) do |response|
        response
      end
    end

    def fetch()
    end
  end
end
