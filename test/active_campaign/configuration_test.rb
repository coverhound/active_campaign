require "test_helper"
require "minitest/spec"

module ActiveCampaign
  class ConfigurationTest < Minitest::Test
    extend Minitest::Spec::DSL

    let(:required_config) { ActiveCampaign::Configuration::REQUIRED }
    let(:optional_config) { ActiveCampaign::Configuration::OPTIONAL }
    let(:options) { required_config + optional_config }

    describe "::new" do
      subject do
        ActiveCampaign::Configuration.new do |config|
          options.each do |method_name|
            config.public_send("#{method_name}=", method_name)
          end
        end
      end

      describe "when missing required configuration" do
        let(:options) { required_config[1..-1] }

        it "raises an ArgumentError" do
          assert_raises(ArgumentError) { subject }
        end
      end

      it "assigns the configuration" do
        subject

        options.each do |method_name|
          assert_equal method_name, subject.public_send(method_name)
        end
      end
    end
  end
end
