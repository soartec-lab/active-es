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
      body = { query: { match: attributes } }
      result = client.search index: index, type: type, body: body

      result.dig("hits", "hits").map do |hit|
        new(hit["_source"].merge({ id: hit["_id"], score: hit["_score"] }))
      end
    end

    # usingd
    # ActiveSearch::Base.multi_match(field: ['title', 'description'], match: 'sample 1')
    # => [#<Content:0x00007fffbc2746b0 @description="sample description 1", @id="W_KDRmgBeTay2K79iAf7", @score=0.5753642, @title="sample title 1">]
    #
    # ActiveSearch::Base.multi_match(fields: ['title', 'description'], keyword: ['sample', '1'])
    # => [#<Content:0x00007fffbc2746b0 @description="sample description 1", @id="W_KDRmgBeTay2K79iAf7", @score=0.5753642, @title="sample title 1">]
    #
    # ActiveSearch::Base.multi_match(fields: ['title', 'description'], match: ['sample', '1'], operator: 'or')
    # => [
    #      #<Content:0x00007ffff712d280 @description="sample description 1", @id="W_KDRmgBeTay2K79iAf7", @score=0.5753642, @title="sample title 1">,
    #      #<Content:0x00007ffff712c6a0 @description="sample description 2", @id="XPKDRmgBeTay2K79ywfz", @score=0.2876821, @title="sample title 2">
    #    ]
    #
    # ActiveSearch::Base.multi_match(fields: '', match: [])
    # => []
    def multi_match(fields:, match:, operator: 'and')
      raise ArgumentError, "operator accepts only 'and','or'" unless operator =~ /and|or/

      keyword = Array(match).join(' ')
      body = { query: { multi_match: { fields: fields, query: keyword, operator: operator} } }
      result = client.search index: index, type: type, body: body

      result.dig("hits", "hits").map do |hit|
        new(hit["_source"].merge({ id: hit["_id"], score: hit["_score"] }))
      end
    end

    # using
    # ActiveSearch::Base.must(title: 'sample', description: '1')
    # => [#<Content:0x00007fffbc2746b0 @description="sample description 1", @id="W_KDRmgBeTay2K79iAf7", @score=0.5753642, @title="sample title 1">]
    #
    # ActiveSearch::Base.must(title: '')
    # => []
    def must(attributes = {})
      query = attributes.map { |attr| { match: Hash[*attr] } }

      body = { query: { bool: { must: query } } }
      result = client.search index: index, type: type, body: body

      result.dig("hits", "hits").map do |hit|
        new(hit["_source"].merge({ id: hit["_id"], score: hit["_score"] }))
      end 
    end
  end
end