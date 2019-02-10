module ActiveSearch
  # = Active Record Attribute Methods
  module AttributeMethods
    extend ActiveSupport::Concern

    included do
      attr_accessor :id, :score
    end
  end
end