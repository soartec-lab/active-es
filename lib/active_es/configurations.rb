module ActiveEs
  class Configurations
    attr_reader :connection_url, :index

    def initialize
      config = Rails.application.config.searchengine
      @connection_url = "#{config["host"]}:#{config["port"]}"
      @index = config["index"]
    end
  end
end
