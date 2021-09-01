# frozen_string_literal: true

require 'json'

module CovaApi
  class Inventory
    def self.by_location(location_id)
      parsed_inventory(
        CovaApi.inventory_availability.get(
          "/Companies(#{CovaApi.company_id})/Entities(#{location_id})/CatalogItems"
        )
      ).map { |data| new(data) }
    end

    def self.find_by(location_id:, product_id:)
      new parsed_inventory(
        CovaApi.inventory_availability.get(
          "/Companies(#{CovaApi.company_id})/Entities(#{location_id})/CatalogItems(#{product_id})"
        )
      )
    rescue OAuth2::Error => e
      message = e.message && JSON.parse(e.message)
      raise unless message && message['Message'] == 'Resource cannot be found'

      new({ 'Id' => product_id, 'Quantity' => 0 })
    end

    attr_accessor :data, :product_id, :location_id, :quantity

    def initialize(data = {})
      @data = data
      @product_id = data['Id']
      @location_id = data['EntityId']
      @quantity = data['Quantity']
    end

    private_class_method def self.parsed_inventory(result)
      json = JSON.parse result.body
      json['_embedded']['self'] || json
    end
  end
end
