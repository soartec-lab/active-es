require "active_es/schema/definition"
require "active_es/schema/describe"
require "active_es/schema/control"

module ActiveEs
  module Schema
    include Definition
    include Describe
    include Control
  end
end