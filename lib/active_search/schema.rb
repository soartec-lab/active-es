require "active_search/schema/definition"
require "active_search/schema/describe"
require "active_search/schema/control"

module ActiveSearch
  module Schema
    include Definition
    include Describe
    include Control
  end
end