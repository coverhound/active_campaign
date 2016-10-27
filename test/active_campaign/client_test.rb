require 'test_helper'
require 'minitest/spec'

class ActiveCampaign::ClientTest < Minitest::Test
  extend Minitest::Spec::DSL

  let(:config) do
    useful_mock("Config", stuff: "here")
  end
  let(:subject) { ActiveCampaign::Client.new(config: config) }
end
