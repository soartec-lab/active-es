module ActiveSearch
  module Schema
    module Control
      extend ActiveSupport::Concern

      def healthy?
        status = client.cluster.health["status"]
        status == "green"
      end
    end
  end
end