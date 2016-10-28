$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "active_campaign"

require "minitest/autorun"
require "minitest/spec"
require 'mocha/mini_test'

Mocha::Configuration.prevent(:stubbing_non_existent_method)

class Minitest::Test
  extend Minitest::Spec::DSL

  def assert_true(value)
    assert value == true, "Expected #{value} to be true"
  end

  def assert_false(value)
    assert value == false, "Expected #{value} to be false"
  end
end

if ENV["SPEC"]
  require 'minitest/reporters'
  reporter_options = { color: true }
  Minitest::Reporters.use!(
    Minitest::Reporters::SpecReporter.new(reporter_options),
    ENV,
    Minitest.backtrace_filter
  )
end
