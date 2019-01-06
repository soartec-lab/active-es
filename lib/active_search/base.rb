module ActiveSearch
  class Base
    extend Scheme
    extend Quering
    extend Persistence
    include Validates
    include Client
    
    attr_reader :attributes

    def initialize(attributes = nil)
      @attributes = attributes
    end
  end
end