module ActiveEs
  class Configurations
    attr_reader :connection_url, :index

    def initialize
      load_confing = YAML.load_file(Rails.root.join('config', 'searchengine.yml'))
      config = load_confing[Rails.env]
      @connection_url = "#{config["host"]}:#{config["port"]}"
      @index = config["index"]
    end
  end
end
