# frozen_string_literal: true

module CovaApi
  class OrderDiscount
    def self.body_data(discount_data)
      data = { 'Discount' => {} }
      discount_data.each do |d|
        data['Discount'][d[:type]] = if d[:value].is_a?(Array)
                                       d[:value].map { |discount| new(discount).body_data }
                                     else
                                       d[:value]
                                     end
      end
      data
    end

    attr_accessor :name, :value, :value_type

    def initialize(name:, value:, value_type:)
      @name = name
      @value = value
      @value_type = value_type
    end

    def body_data
      {
        'Name' => name,
        'Value' => value,
        'ValueType' => value_type
      }
    end
  end
end
