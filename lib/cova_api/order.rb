# frozen_string_literal: true

require 'json'

module CovaApi
  class Order
    attr_accessor :id, :entity_id, :first_name, :last_name, :customer_id, :is_delivery, :items, :taxes, :discount

    def initialize(
      entity_id:, first_name:, last_name:, customer_id:, items:, id: nil, is_delivery: false, taxes: [], discount: nil
    )
      @id = id
      @entity_id = entity_id
      @first_name = first_name
      @last_name = last_name
      @customer_id = customer_id
      @items = items.map { |item| Item.new item }
      @taxes = taxes.map { |tax| Tax.new tax }
      @discount = discount
      @is_delivery = is_delivery
    end

    def save
      raise AlreadyExists if id

      response = CovaApi.sales_order.post(
        '/CovaOrder',
        {
          body: body_data.to_json,
          headers: {
            'Accept' => 'application/json',
            'Content-Type' => 'application/json'
          }
        }
      )
      self.id = response.parsed['id']
      self
    end

    def add_payments!(payments)
      raise RecordNotFound unless id

      CovaApi.sales_order.post(
        '/CovaOrderPayment',
        {
          body: Payment.body_data(payments).to_json,
          headers: {
            'Accept' => 'application/json',
            'Content-Type' => 'application/json'
          }
        }
      )
    end

    private

    def body_data
      {
        'CompanyId' => CovaApi.company_id,
        'EntityId' => entity_id,
        'FirstName' => first_name,
        'LastName' => last_name,
        'customerId' => customer_id,
        'IsDelivery' => is_delivery,
        'Items' => items.map(&:body_data)
      }
        .merge(discount ? Discount.body_data(discount) : {})
        .merge(taxes.size.zero? ? {} : { 'Taxes' => taxes.map(&:body_data) })
    end
  end
end
