require "test_helper"
require "minitest/spec"

class ActiveCampaignTest < Minitest::Test
  extend Minitest::Spec::DSL

  subject { ActiveCampaign }
  let(:dummy_client) { mock("Dummy Client") }

  describe "::client" do
    before do
      ActiveCampaign::Registry.any_instance.expects(:[]).with(:dummy).returns(dummy_client)
    end

    it "finds the client by name" do
      assert_equal dummy_client, subject.client(:dummy)
    end
  end

  describe "::register_client" do
    let(:api_key) { "adsjfokij-0931jf9301jf" }
    let(:api_host) { "http://example.com" }

    it "adds the client to the registry" do
      subject.register_client(:dummy) do |config|
        config.api_key = api_key
        config.api_host = api_host
      end

      refute_nil subject.client(:dummy)
    end
  end
end
