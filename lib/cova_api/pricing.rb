# frozen_string_literal: true

require 'json'

module CovaApi
  class Pricing
    def self.by_location(location_id)
      parsed_pricing(
        CovaApi.pricing.get(
          "/Companies(#{CovaApi.company_id})/Entities(#{location_id})/CatalogItems"
        )
      ).map { |data| new(data) }
    end

    def self.find_by(location_id:, product_id:)
      new parsed_pricing(
        CovaApi.pricing.get(
          "/Companies(#{CovaApi.company_id})/Entities(#{location_id})/CatalogItems(#{product_id})/Pricing"
        )
      ).first
    end

    attr_accessor :data, :product_id, :location_id, :price, :override_price

    def initialize(data = {})
      @data = data
      @product_id = data['CatalogItemId']
      @location_id = data['EntityId']
      @price = data['RegularPrice']
      @override_price = data['OverridePrice']
    end

    private_class_method def self.parsed_pricing(result)
      json = JSON.parse result.body
      json['_embedded']['self'] || json
    end
  end
end
