module ActiveCampaign
  class Configuration
    REQUIRED = %i(api_key api_host).freeze
    OPTIONAL = %i(api_path).freeze

    def initialize
      yield self
      validate_required_config
    end

    attr_accessor *REQUIRED, *OPTIONAL

    def url
      [api_host, api_path].join
    end

    def api_path
      @api_path || "/admin/api.php"
    end

    private

    def validate_required_config
      missing_config = REQUIRED.select { |method_name| public_send(method_name).nil? }
      return if missing_config.empty?

      raise ArgumentError, "The following configuration data is required: #{missing_config.join(', ')}"
    end
  end
end
