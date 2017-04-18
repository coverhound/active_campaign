require "test_helper"
require "minitest/spec"

class ActiveCampaign::ResourceTest < Minitest::Test
  extend Minitest::Spec::DSL

  action_name = :create
  action_mapping = :resource_add
  let(:resource) do
    Class.new(ActiveCampaign::Resource) do
      action action_name => action_mapping
    end
  end
  let(:params) { { email: "testing@email.com" } }
  subject { resource.new(params) }

  describe "actions" do
    describe "when supported" do
      it "returns the action mapping" do
        assert_equal action_mapping, subject.action(action_name)
      end
    end

    describe "when unsupported" do
      it "returns the action mapping" do
        assert_raises RuntimeError do
          subject.action(:foo)
        end
      end
    end

    describe "when no email param" do
      let(:params) { {} }
      it "raises an error" do
        assert_raises RuntimeError do
          subject.action(action_name)
        end
      end
    end
  end
end
