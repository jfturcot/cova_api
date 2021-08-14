# frozen_string_literal: true

module CovaApi
  class Customer
    def self.all
      parsed_customers(
        CovaApi.customer.get("/Companies(#{CovaApi.company_id})/Customers")
      ).map { |data| new data }
    end

    def self.search(query)
      parsed_customers(
        CovaApi.customer.get("/Companies(#{CovaApi.company_id})/CustomerSearch?$filter=Criteria eq '#{query}'")
      ).map { |data| new data }
    end

    private_class_method def self.parsed_customers(result)
      json = JSON.parse result.body
      json['_embedded']['self']
    end

    attr_accessor :data, :id

    def initialize(data)
      @data = data
      @id = data['Id']
    end
  end
end
