module ActiveSearch
  # = Active Record Attribute Methods
  module AttributeMethods
    extend ActiveSupport::Concern

    included do
      field_names.each do |attr|
        attr_accessor attr
      end
      attr_accessor :id, :score
    end
  end
end