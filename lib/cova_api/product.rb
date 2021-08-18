# frozen_string_literal: true

module CovaApi
  class Product
    def self.all
      result = CovaApi.catalog.get "/Companies(#{CovaApi.company_id})/Catalog/Items"
      result.parsed.map { |data| new data }
    end

    def self.search(query)
      result = CovaApi.catalog.get "/Companies(#{CovaApi.company_id})/Catalog/Search?SearchTerms=#{query}"
      result.parsed['Items'].map { |data| new data }
    end

    def self.find(id)
      result = CovaApi.catalog.get "/Companies(#{CovaApi.company_id})/Catalog/Items(#{id})/ProductDetails"
      new result.parsed.merge('CatalogItemId' => id)
    end

    attr_accessor :data, :id

    def initialize(data = {})
      @data = data
      @id = data['CatalogItemId']
    end

    def inventory_by_location(location_id)
      CovaApi::Inventory.find_by(product_id: id, location_id: location_id)
    end

    def pricing_by_location(location_id)
      CovaApi::Pricing.find_by(product_id: id, location_id: location_id)
    end
  end
end
