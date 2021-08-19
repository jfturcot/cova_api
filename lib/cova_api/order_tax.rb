# frozen_string_literal: true

module CovaApi
  class OrderTax
    attr_accessor :tax_id, :amount

    def initialize(tax_id:, amount:)
      @tax_id = tax_id
      @amount = amount
    end

    def body_data
      {
        'TaxId' => tax_id,
        'TaxAmount' => amount
      }
    end
  end
end
