module ActiveEs
  class Base
    extend Schema
    extend Quering
    extend Persistence
    include Client
    include AttributeMethods
    include ActiveModel::Model
  end
end