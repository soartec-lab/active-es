require "active_es/version"

module ActiveEs
  extend ActiveSupport::Autoload

  autoload :Base
  autoload :Client
  autoload :Configurations
  autoload :Persistence
  autoload :Quering
  autoload :Schema
  autoload :AttributeMethods
end
