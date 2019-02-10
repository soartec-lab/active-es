require 'elasticsearch'

module ActiveSearch
  module Client
    extend ActiveSupport::Concern

    included do
      cattr_accessor :client

      def self.connect
        configrations = ActiveSearch::Configurations.new
        @@client = Elasticsearch::Client.new url: configrations.connection_url  
      end
      self.connect
    end
  end
end