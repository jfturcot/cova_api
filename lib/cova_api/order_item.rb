# frozen_string_literal: true

module CovaApi
  class OrderItem
    attr_accessor :name, :catalog_item_id, :quantity, :price

    def initialize(name:, catalog_item_id:, quantity:, price:)
      @name = name
      @catalog_item_id = catalog_item_id
      @quantity = quantity
      @price = price
    end

    def body_data
      {
        'Name' => name,
        'CatalogItemId' => catalog_item_id,
        'Quantity' => quantity,
        'SellAtPricePerUnit' => price
      }
    end
  end
end
