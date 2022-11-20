# frozen_string_literal: true

require 'json'

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

    def self.fetch(ids)
      results = get_results_for_fetch ids
      products = []
      results.parsed['CatalogItems'].each do |key, value|
        products.push(new(value.merge('CatalogItemId' => key)))
      end
      products
    end

    def self.collection_for(id)
      parsed_result = CovaApi.catalog.get("/Companies(#{CovaApi.company_id})/Catalog/Items(#{id})/Structure").parsed

      variant_ids = variant_ids_from_structure parsed_result
      data = {
        slug: parsed_result['Slug'],
        name: parsed_result['Name'],
        variants: fetch(variant_ids)
      }
      data[:sku] = data[:variants].first.data['MasterProductId'] if data[:variants].first&.data

      data
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

    private_class_method def self.get_results_for_fetch(ids)
      CovaApi.catalog.post(
        "/Companies(#{CovaApi.company_id})/Catalog/Items/ProductDetails/Bulk",
        {
          body: { 'CatalogItemIds' => ids }.to_json,
          headers: {
            'Accept' => 'application/json',
            'Content-Type' => 'application/json'
          }
        }
      )
    end

    private_class_method def self.variant_ids_from_structure(structure)
      structure['Variations'].map { |variation| variation['CatalogItemIds'].first }
    end
  end
end
