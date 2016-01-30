module Gracenote
  module QueryBuilder
    def build_query(cmd, lang: nil, auth: nil)
      # <OPTION>
      #   <PARAMETER>SELECT_EXTENDED</PARAMETER>
      #   <VALUE>COVER,REVIEW,ARTIST_BIOGRAPHY,ARTIST_IMAGE,ARTIST_OET,MOOD,TEMPO</VALUE>
      # </OPTION>
      # <OPTION>
      #   <PARAMETER>SELECT_DETAIL</PARAMETER>
      #   <VALUE>GENRE:3LEVEL,MOOD:2LEVEL,TEMPO:3LEVEL,ARTIST_ORIGIN:4LEVEL,ARTIST_ERA:2LEVEL,ARTIST_TYPE:2LEVEL</VALUE>
      # </OPTION>

      builder = Nokogiri::XML::Builder.new do |xml|
        xml.QUERIES {
          if auth
            xml.AUTH {
              xml.CLIENT auth[:client]
              xml.USER auth[:user]
            }
          end
          xml.LANG lang if lang
          xml.QUERY(CMD: cmd) {
            yield(xml)
          }
        }
      end
      builder.to_xml
    end
  end
end
