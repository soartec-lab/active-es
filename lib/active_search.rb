require "active_search/version"

module ActiveSearch
  extend ActiveSupport::Autoload

  autoload :Base
  autoload :Client
  autoload :Configurations
  autoload :Persistence
  autoload :Quering
  autoload :Schema
  autoload :AttributeMethods
end
