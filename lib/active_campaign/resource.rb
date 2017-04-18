module ActiveCampaign
  class Resource
    def initialize(**params)
      @params = format_params(params)
    end

    def format_params(params)
      raise "no email attribute included in params" if params[:email].nil?

      params.map do |k, v|
        [:email, :phone].include?(k) ? [k, v] : ["%#{k.upcase}%, 0".to_sym, v]
      end.to_h
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
