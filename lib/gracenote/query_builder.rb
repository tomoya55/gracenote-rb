module Gracenote
  module QueryBuilder
    def build_query(cmd, auth: nil, lang: nil, country: nil)
      Nokogiri::XML::Builder.new do |xml|
        xml.QUERIES {
          if auth
            xml.AUTH {
              xml.CLIENT auth[:client]
              xml.USER auth[:user]
            }
          end
          xml.LANG lang if lang
          xml.COUNTRY country if country
          xml.QUERY(CMD: cmd) {
            yield(xml)
          }
        }
      end
    end
  end
end
