$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "gracenote-rb"

require "minitest/autorun"
require "minitest/reporters"
require "minitest/power_assert"
require "webmock/minitest"
require "pry"

Minitest::Reporters.use!
