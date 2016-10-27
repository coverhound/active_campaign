require "test_helper"
require "minitest/spec"

class ActiveCampaign::ResponseTest < Minitest::Test
  extend Minitest::Spec::DSL

  subject do
    ActiveCampaign::Response.new(body: response_body, status: response_status)
  end

  describe "when HTTP 200 and code is success" do
    let(:response_body) do
      <<-JSON
      {"result_message": "Foo", "result_code": 1}
      JSON
    end
    let(:response_status) { 200 }

    it "succeeds" do
      assert_true subject.success?
      assert_false subject.failed?
    end
  end

  describe "when HTTP 200 but no success" do
    let(:response_body) do
      <<-JSON
      {"result_message": "Email is required", "result_code": 0}
      JSON
    end
    let(:response_status) { 200 }

    it "it fails" do
      assert_false subject.success?
      assert_true subject.failed?
    end
  end

  describe "when not HTTP 200" do
    let(:response_body) do
      <<-JSON
      {"result_message": "Email is required", "result_code": 1}
      JSON
    end
    let(:response_status) { 404 }

    it "it fails" do
      assert_false subject.success?
      assert_true subject.failed?
    end
  end
end
