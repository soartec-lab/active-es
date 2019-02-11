module ActiveEs
  module Schema
    module Definition
      extend ActiveSupport::Concern

      mattr_accessor :properties, default: {}

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
        attr_accessor field
      end

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
    end
  end
end