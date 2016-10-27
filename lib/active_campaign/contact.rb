require "active_campaign/resource"

module ActiveCampaign
  class Contact < Resource
    def initialize(email:, **params)
      @params = params.merge(email: email)
    end

    action create: :contact_add
  end
end
