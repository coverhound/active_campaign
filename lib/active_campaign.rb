require "active_campaign/configuration"
require "active_campaign/client"
require "active_campaign/registry"

require "active_campaign/contact"
# Example usage:
#   ActiveCampaign.register_client(:personal_lines, default: true) do |config|
#     config.email = "david@example.com"
#     config.api_key = "fdalsdjf1242139210"
#   end
#
# Calling client without a name uses the default
#   resource = ActiveCampaign::Contact.new(email: "hi@example.com")
#   ActiveCampaign.client.create!(resource)
#
# Calling client with a name uses that client specifically
#   resource = ActiveCampaign::Contact.new(email: "hi@example.com")
#   ActiveCampaign.client(:personal_lines).create!(resource)
#
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
