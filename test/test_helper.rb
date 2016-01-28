$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "gracenote-rb"

require "minitest/autorun"
require "minitest/reporters"
require "minitest/power_assert"
require "webmock/minitest"
require "pry"

Minitest::Reporters.use!

class WebMock::RequestStub
  def to_return_xml(hash, options = {})
    options[:body] = Gyoku.xml(hash, key_converter: :upcase)
    options[:headers] ||= {}
    options[:headers]["Content-Type"] = "application/xml"
    to_return(options)
  end
end
