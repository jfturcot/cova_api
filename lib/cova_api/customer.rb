# frozen_string_literal: true

module CovaApi
  class Customer
    def self.all
      parsed_customers CovaApi.customer.get("/Companies(#{CovaApi.company_id})/Customers")
    end

    def self.search(query)
      parsed_customers(
        CovaApi.customer.get("/Companies(#{CovaApi.company_id})/CustomerSearch?$filter=Criteria eq '#{query}'")
      )
    end

    private_class_method def self.parsed_customers(result)
      json = JSON.parse result.body
      json['_embedded']['self']
    end
  end
end
