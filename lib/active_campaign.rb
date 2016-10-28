require "active_campaign/configuration"
require "active_campaign/client"
require "active_campaign/registry"

# Resources
require "active_campaign/contact"

module ActiveCampaign
  class << self
    def client(name = :default)
      clients[name]
    end

    def register_client(name, default: false, &block)
      config = ActiveCampaign::Configuration.new(&block)
      client = ActiveCampaign::Client.new(config: config)

      clients.register(:default, client) if default
      clients.register(name, client)
    end

    private

    def clients
      @clients ||= ActiveCampaign::Registry.new("Client")
    end
  end
end
