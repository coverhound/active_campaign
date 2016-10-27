require "json"

module ActiveCampaign
  class Response
    def initialize(body:, status:)
      @status = status
      @body = parse(body)
      @original_body = body
    end

    attr_reader :status, :body, :original_body

    def message
      body["result_message"]
    end

    def error
      message if failed?
    end

    def success?
      status == 200 && body["result_code"] == 1
    end

    def failed?
      !success?
    end

    private

    def parse(body)
      JSON.parse(body)
    rescue JSON::ParserError
      {}
    end
  end
end
