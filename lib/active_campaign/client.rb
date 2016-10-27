require "active_campaign/connection"

module ActiveCampaign
  class Client
    def initialize(config:)
      @connection = Connection.new(config: config)
    end

    def create!(resource)
      connection.post(resource.action(:create), resource.params)
    end

    def update!(resource)
      connection.post(resource.action(:update), resource.params)
    end

    def delete!(resource)
      connection.get(resource.action(:delete), resource.params)
    end

    def find!(resource)
      connection.get(resource.action(:find), resource.params)
    end

    def list!(resource)
      connection.get(resource.action(:list), resource.params)
    end

    private

    attr_reader :connection
  end
end
