module ActiveCampaign
  class Resource
    def initialize(**params)
      @params = params
    end

    attr_reader :params

    def self.action(action_pair)
      actions.merge!(action_pair)
    end

    def self.actions
      @actions ||= {}
    end

    def action(key)
      self.class.actions[key] or unsupported_action(key)
    end

    private

    def unsupported_action(action)
      raise "#{action} is not supported for #{self.class.name}"
    end
  end
end
