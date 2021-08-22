# frozen_string_literal: true

module CovaApi
  class Customer::ContactMethod
    attr_accessor :type, :value, :default

    def initialize(
      type:, value:, default: false
    )
      @type = type
      @value = value
      @default = default
    end

    def body_data
      {
        'ContactMethodCategoryId' => type_map(type)[:category_id],
        'ContactMethodTypeId' => type_map(type)[:type_id],
        'Value' => value,
        'DoNotContact' => false,
        'Default' => default
      }
    end

    private

    def type_map(type)
      @type_map ||= {
        category_id: case type.to_sym
                     when :email
                       2
                     when :phone
                       1
                     end,
        type_id: case type.to_sym
                 when :email
                   9
                 when :phone
                   3
                 end
      }
    end
  end
end
