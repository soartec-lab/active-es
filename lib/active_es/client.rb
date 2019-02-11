require 'elasticsearch'

module ActiveEs
  module Client
    extend ActiveSupport::Concern

    included do
      cattr_accessor :client

      def self.connect
        configrations = ActiveEs::Configurations.new
        @@client = Elasticsearch::Client.new url: configrations.connection_url  
      end
      self.connect
    end
  end
end