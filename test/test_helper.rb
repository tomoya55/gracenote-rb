$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "gracenote-rb"

require "minitest/autorun"
require "minitest/reporters"
require "minitest/power_assert"
require "webmock/minitest"
require "rspec/mocks"
require "pry"

Minitest::Reporters.use!

class Minitest::Test
  include ::RSpec::Mocks::ExampleMethods

  def before_setup
    ::RSpec::Mocks.setup
    super
  end

  def after_teardown
    super
    ::RSpec::Mocks.verify
  ensure
    ::RSpec::Mocks.teardown
  end
end
