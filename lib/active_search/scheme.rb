module ActiveSearch
  module Scheme
    @@properties = {}

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

    def property(field, **optins)
      @@properties[field] = options
    end

    def properties
      @@properties
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