class Content < ActiveSearch::Base
  property :title, type: 'text', analyzer: 'kuromoji'
  property :description, type: 'text', analyzer: "kuromoji"
end
