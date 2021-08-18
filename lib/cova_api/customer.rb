# frozen_string_literal: true

require 'json'

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

    def self.find(id)
      new parsed_customer(
        CovaApi.customer.get("/Companies(#{CovaApi.company_id})/CustomerFull(#{id})")
      )
    rescue OAuth2::Error => e
      message = e.message && JSON.parse(e.message)
      raise unless message && message['Message'] == 'Resource cannot be found'

      raise RecordNotFound
    end

    private_class_method def self.parsed_customers(result)
      json = JSON.parse result.body
      json['_embedded']['self'] || []
    end

    private_class_method def self.parsed_customer(result)
      JSON.parse result.body
    end

    attr_accessor :data, :id

    def initialize(data = {})
      setup data
    end

    def save
      raise AlreadyExists if id

      setup parsed_customer(
        CovaApi.customer.post("/Companies(#{CovaApi.company_id})/CustomerFull", { body: data.to_json })
      )

      self
    end

    private

    def setup(data)
      @data = data
      @id = data['Id']
    end

    def parsed_customer(result)
      Customer.send(:parsed_customer, result)
    end
  end
end
