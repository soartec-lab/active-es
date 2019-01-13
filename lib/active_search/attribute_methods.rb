module ActiveSearch
  # = Active Record Attribute Methods
  module AttributeMethods
    extend ActiveSupport::Concern

    included do
      propertie_names.each do |attr|
        class_eval { attr_accessor attr }
      end
    end
  end
end