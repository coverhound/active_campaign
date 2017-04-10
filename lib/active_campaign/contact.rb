require "active_campaign/resource"

module ActiveCampaign
  class Contact < Resource
    def initialize(email:, **params)
      @params = params.merge(email: email)
    end

    action find: :contact_view_email
    action create: :contact_add
    action update: :contact_edit
  end
end
