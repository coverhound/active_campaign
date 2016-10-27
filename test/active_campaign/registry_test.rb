require "test_helper"
require "minitest/spec"

module ActiveCampaign
  class RegistryTest < Minitest::Test
    extend Minitest::Spec::DSL

    subject { ActiveCampaign::Registry.new(registry_name) }
    let(:registry_name) { "Dummy" }

    describe "#find" do
      describe "when the item is not found" do
        it "raises an ArgumentError" do
          assert_raises(ArgumentError) do
            subject.find(:not_found)
          end
        end
      end

      describe "when the item exists" do
        let(:found) { "Found" }
        before do
          subject.register(:found, found)
        end

        it "finds the item" do
          assert_equal found, subject.find(:found)
        end
      end
    end
  end
end
