require 'elasticsearch'

module ActiveSearch
  module Client
    extend ActiveSupport::Concern

    included do
      def self.connect
        configrations = ActiveSearch::Configurations.new
        @@client = Elasticsearch::Client.new url: configrations.connection_url  
      end
      self.connect

      def self.client
        @@client
      end
    end
  end
end