module ActiveSearch
  module Quering
    # using
    # ActiveSearch::Base.find('kQiD9WcB0q1F0jm0anRr')
    # => {"title"=>"title1", "description"=>"description1"}
    def find(id)
      result = client.get index: index, type: type, id: id
      result.dig("_source", "attributes")
    end

    def count
      client.count["count"]
    end

    # using
    # ActiveSearch::Base.match(title: "title1")
    # => {"title"=>"title1", "description"=>"description1"}
    # ActiveSearch::Base.match(title: 'invalid_title')
    # => []

    def match(attributes = nil)
      object = new(attributes)
      object.validate!

      body = { query: { match: attributes } }

      result = client.search index: index, type: type, body: body
      result.dig("hits", "hits").map { |hit| hit["_source"] }
    end
  end
end