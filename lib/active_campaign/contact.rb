require "active_campaign/resource"

module ActiveCampaign
  class Contact < Resource
    action find: :contact_view_email
    action create: :contact_add
    action update: :contact_edit
  end
end
