# frozen_string_literal: true

module CovaApi
  class Product
    def self.all
      result = CovaApi.catalog.get "/Companies(#{CovaApi.company_id})/Catalog/Items"
      result.parsed
    end

    def self.search(query)
      result = CovaApi.catalog.get "/Companies(#{CovaApi.company_id})/Catalog/Search?SearchTerms=#{query}"
      result.parsed['Items']
    end
  end
end
