module Gracenote
  module Xml
    def xml(hash)
      Gyoku.xml(hash, key_converter: :upcase)
    end
  end
end
