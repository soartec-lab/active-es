module ActiveSearch
  module Scheme
    def create_scheme
      client.indices.create index: index, body: mappings
    end

    def delete_scheme
      client.indices.delete index: index
    end

    def healthy?
      status = client.cluster.health["status"]
      status == "green"
    end

    def properties
      {
        title: { type: 'text', analyzer: "kuromoji" },
        description: { type: 'text', analyzer: "kuromoji" }
      }
    end

    def mappings
      { mappings: { "#{type}" => { properties: properties } } }
    end

    def index
      ActiveSearch::Configurations.new.index
    end

    def type
      name.tableize
    end
  end
end