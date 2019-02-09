module ActiveSearch
  module Schema
    @@properties = {}

    def create_schema
      client.indices.create index: index, body: mappings
    end

    def delete_schema
      client.indices.delete index: index
    end

    def reset_schema
      delete_schema
      create_schema
    end

    def healthy?
      status = client.cluster.health["status"]
      status == "green"
    end

    def index
      ActiveSearch::Configurations.new.index
    end

    def type
      name.tableize
    end

    def mappings
      { mappings: { "#{type}" => { properties: properties } } }
    end

    def properties
      return @@properties.merge!(defined_propeties) if @@properties.empty?
      
      @@properties
    end

    def defined_propeties
      result = client.indices.get_mapping index: index
      result.dig(index, "mappings", type, "properties").symbolize_keys  
    end

    def field_names
      properties.keys
    end

    FieldDetaTypes = %w(
      text keyword
      long integer short byte
      double float half_float scaled_float
      date
      boolean
      binary
      integer_range float_range long_range double_range date_range
    )

    def property(field, **options)
      if options.values.all? { |key| FieldDetaTypes.exclude?(key) }
        raise ArgumentError('invalid field deta types')
      end

      properties[field] = options
    end
  end
end