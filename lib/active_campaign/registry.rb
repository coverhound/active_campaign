module ActiveCampaign
  class Registry
    def initialize(type)
      @items = {}
      @type = type
    end

    def find(name)
      return items[name] if registered?(name)
      raise ArgumentError, "#{type} not registered for #{name}"
    end

    alias_method :[], :find

    def register(name, item)
      items[name] = item
    end

    def registered?(name)
      items.key?(name)
    end

    private

    attr_reader :items, :type
  end
end
