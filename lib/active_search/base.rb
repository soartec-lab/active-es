module ActiveSearch
  class Base
    extend Scheme
    extend Quering
    extend Persistence
    include Client
    include AttributeMethods
    include ActiveModel::Model
  end
end