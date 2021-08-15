# frozen_string_literal: true

module CovaApi
  class Inventory
    def self.by_location(location_id)
      parsed_inventory(
        CovaApi.inventory_availability.get(
          "/Companies(#{CovaApi.company_id})/Entities(#{location_id})/CatalogItems/SellingRoomOnly"
        )
      ).map { |data| new(data) }
    end

    def self.find_by(location_id:, product_id:)
      new parsed_inventory(
        CovaApi.inventory_availability.get(
          "/Companies(#{CovaApi.company_id})/Entities(#{location_id})/CatalogItems(#{product_id})/SellingRoomOnly"
        )
      )
    end

    attr_accessor :data, :product_id, :quantity

    def initialize(data)
      @data = data
      @product_id = data['Id']
      @quantity = data['Quantity']
    end

    private_class_method def self.parsed_inventory(result)
      json = JSON.parse result.body
      json['_embedded']['self'] || json
    end
  end
end
