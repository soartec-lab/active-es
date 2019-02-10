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

    def all
      body = { query: { match_all: {} } }
      result = client.search index: index, type: type, body: body

      result_instance(result)
    end

    # using
    # It retrieves data that matches one of the attributes specified by the argument.
    # The value of Hash specified by attributes is an empty string delimiter and can be specified more than once.
    # In that case, we will retrieve data whose value matches one of the specified keys.
    # Unlike the term method, Analyze uses it for the field that Analyze needs to do.
    #
    # ActiveSearch::Base.match(title: "sample")
    # => [
    #      #<Content:0x00007fffc4637fb0 @description="sample description 1", @id="W_KDRmgBeTay2K79iAf7", @score=0.2876821, @title="sample title 1">,
    #      #<Content:0x00007fffc3f0c7b8 @description="sample description 2", @id="XPKDRmgBeTay2K79ywfz", @score=0.2876821, @title="sample title 2">
    #    ]
    # ActiveSearch::Base.match(title: '1 0')
    # => [#<Content:0x00007fffdea9fea8 @description="sample description 1", @id="W_KDRmgBeTay2K79iAf7", @score=0.2876821, @title="sample title 1">]
    # 
    # ActiveSearch::Base.match(title: 'invalid_title')
    # => []
    def match(attributes = nil)
      body = { query: { match: attributes } }
      result = client.search index: index, type: type, body: body

      result_instance(result)
    end


    # using
    # In the argument, pass field to key and Hash with numerical value to value.
    # Unlike the match method, since Analyze is not performed,
    # high-speed searching is possible for fields where Analyze is unnecessary.
    # 
    # ActiveSearch::Base.term(number: 3)
    # => [#<Content:0x00007fffe60264b0 @description="sample description 1", @id="Hhp01mgBhOPWXkxaeleN", @number=3, @score=1.0, @title="sample title 1">]
    def term(attributes = nil)
      body = { query: { term: attributes } }
      result = client.search index: index, type: type, body: body

      result_instance(result)
    end

    # using
    # We perform a search using a match query for multiple fields.
    # The default operation is "and", but an or search is performed by specifying "or" as the key 'operation' of the argument.
    #
    # ActiveSearch::Base.multi_match(field: ['title', 'description'], match: 'sample 1')
    # => [#<Content:0x00007fffbc2746b0 @description="sample description 1", @id="W_KDRmgBeTay2K79iAf7", @score=0.5753642, @title="sample title 1">]
    #
    # ActiveSearch::Base.multi_match(fields: ['title', 'description'], match: ['sample', '1'])
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

      result_instance(result)
    end

    # using
    # Get data that matches all the attributes specified by arguments.
    #
    # ActiveSearch::Base.must(title: 'sample', description: '1')
    # => [#<Content:0x00007fffd5f32230 @description="sample description 1", @id="W_KDRmgBeTay2K79iAf7", @score=0.5753642, @title="sample title 1">]
    #
    # ActiveSearch::Base.must(title: '')
    # => []
    def must(attributes = {})
      query = attributes.map { |attr| { match: Hash[*attr] } }
      body = { query: { bool: { must: query } } }
      result = client.search index: index, type: type, body: body

      result_instance(result)       
    end

    # using
    # It retrieves data that matches one of the attributes specified by the argument.
    #
    # ActiveSearch::Base.should(title: '1')
    # => [#<Content:0x00007fffe7e42ea8 @description="sample description 1", @id="W_KDRmgBeTay2K79iAf7", @score=0.2876821, @title="sample title 1">]
    #
    # ActiveSearch::Base.should(title: '2', description: '1')
    # => [
    #      #<Content:0x00007fffe7fe0198@description="sample description 2", @id="XPKDRmgBeTay2K79ywfz", @score=0.2876821, @title="sample title 2">,
    #      #<Content:0x00007fffe7ff7e88@description="sample description 1", @id="W_KDRmgBeTay2K79iAf7", @score=0.2876821, @title="sample title 1">
    #    ]
    #
    # ActiveSearch::Base.should(title: '')
    # => []
    def should(attributes = {})
      query = attributes.map { |attr| { match: Hash[*attr] } }
      body = { query: { bool: { should: query } } }
      result = client.search index: index, type: type, body: body

      result_instance(result)       
    end

    # using
    # Acquires all data that does not match Hash specified in argument's.
    # Hash values ​​of attributes can be separated by null character and multiple can be specified.
    # In that case, we will retrieve all data that is not included in any of the specified values.
    #
    # ActiveSearch::Base.must_not(title: '1')
    # => [#<Content:0x00007ffff31bc3f8 @description="sample description 2", @id="XPKDRmgBeTay2K79ywfz", @score=1.0, @title="sample title 2">]
    #
    # ActiveSearch::Base.must_not(title: '')
    # => [
    #      #<Content:0x00007ffff3b3bd20 @description="sample description 2", @id="XPKDRmgBeTay2K79ywfz", @score=1.0, @title="sample title 2">,
    #      #<Content:0x00007ffff3b3b938 @description="sample description 1", @id="W_KDRmgBeTay2K79iAf7", @score=1.0, @title="sample title 1">
    #    ]
    #
    # ActiveSearch::Base.must_not(title: '1 2')
    # => []
    def must_not(attributes = {})
      query = attributes.map { |attr| { match: Hash[*attr] } }
      body = { query: { bool: { must_not: query } } }
      result = client.search index: index, type: type, body: body

      result_instance(result)       
    end

    private

    def result_instance(result)
      result.dig("hits", "hits").map do |hit|
        new(hit["_source"].merge({ id: hit["_id"], score: hit["_score"] }))
      end
    end
  end
end