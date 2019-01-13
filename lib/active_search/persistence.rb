module ActiveSearch
  module Persistence
    # using
    # ActiveSearch::Base.create!(title: 'title1', description: 'description1')
    # => true
    #
    # ActiveSearch::Base.create!(title: 'title1')
    # => true
    def create!(attributes = nil)
      result = client.create index: index, type: type, body: attributes
      result["result"] == "created" ? true : raise
    end
  end
end