module ActiveSearch
  module Persistence
    # using
    # ActiveSearch::Base.create!(title: 'title1', description: 'description1')
    # => true
    #
    # ActiveSearch::Base.create!(title: 'title1')
    # => true
    #
    # ActiveSearch::Base.create!(invalid_title: 'title1')
    # => ArgumentError: invalid_title is invalid argment!
    def create!(attributes = nil)
      object = new(attributes)
      object.validate!

      result = client.create index: index, type: type, body: attributes
      result["result"] == "created" ? true : raise
    end
  end
end