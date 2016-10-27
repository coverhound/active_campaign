require "faraday"
require "active_campaign/response"

module ActiveCampaign
  class Connection
    def initialize(config:)
      @connection = build_connection(config)
    end

    def get(action, **params)
      response = connection.get do |conn|
        conn.params.update parameterize(action, **params)
      end
      parse(response)
    end

    def post(action, **params)
      response = connection.post do |conn|
        conn.params.update parameterize(action)
        conn.body = params
      end
      parse(response)
    end

    private

    attr_reader :connection

    def build_connection(config)
      Faraday.new(url: config.url) do |conn|
        conn.request  :url_encoded
        conn.adapter  Faraday.default_adapter
        conn.params.update(api_key: config.api_key, api_output: :json)
      end
    end

    def parameterize(action, **params)
      params.merge(api_action: action)
    end

    def parse(response)
      Response.new(body: response.body, status: response.status)
    end
  end
end
