class Content < ActiveEs::Base
  property :title, type: 'text', analyzer: 'kuromoji'
  property :description, type: 'text', analyzer: "kuromoji"
  property :number, type: 'integer'
  property :rank, type: 'integer'
end
