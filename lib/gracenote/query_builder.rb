module Gracenote
  module QueryBuilder
    def build_query(cmd, lang: nil, auth: nil)
      Nokogiri::XML::Builder.new do |xml|
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
    end
  end
end
