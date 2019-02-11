module ActiveEs
  module Schema
    module Describe
      extend ActiveSupport::Concern

      def index
        ActiveEs::Configurations.new.index
      end

      def type
        name.tableize
      end

      def mappings
        { mappings: { "#{type}" => { properties: properties } } }
      end
    end
  end
end