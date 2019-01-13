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
      result = client.indices.get_mapping index: index
      result.dig(index, "mappings", "contents", "properties").symbolize_keys

      # {
      #   title: { type: 'text', analyzer: "kuromoji" },
      #   description: { type: 'text', analyzer: "kuromoji" }
      # }
    end

    def propertie_names
      properties.keys
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