module ActiveSearch
  module Quering
    # using
    # ActiveSearch::Base.find('W_KDRmgBeTay2K79iAf7')
    # => #<Content:0x00007fffc4637fb0 @description="sample description 1", @id="W_KDRmgBeTay2K79iAf7", @title="sample title 1">
    def find(id)
      result = client.get index: index, type: type, id: id
      new(result["_source"].merge({ id: result["_id"] }))
    end

    def count
      client.count(index: index, type: type)["count"]
    end

    # using
    # ActiveSearch::Base.match(title: "title1")
    # => [
    #      #<Content:0x00007fffc4637fb0 @description="sample description 1", @id="W_KDRmgBeTay2K79iAf7", @score=0.2876821, @title="sample title 1">,
    #      #<Content:0x00007fffc3f0c7b8 @description="sample description 2", @id="XPKDRmgBeTay2K79ywfz", @score=0.2876821, @title="sample title 2">
    #    ]
    # ActiveSearch::Base.match(title: 'invalid_title')
    # => []

    def match(attributes = nil)
      object = new(attributes)
      object.validate!

      body = { query: { match: attributes } }
      result = client.search index: index, type: type, body: body

      result.dig("hits", "hits").map do |hit|
        new(hit["_source"].merge({ id: hit["_id"], score: hit["_score"] }))
      end
    end
  end
end