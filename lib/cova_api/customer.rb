# frozen_string_literal: true

require 'json'

module CovaApi
  class Customer
    def self.all
      parsed_customers(
        CovaApi.customer.get("/Companies(#{CovaApi.company_id})/Customers")
      ).map { |data| new raw: data }
    end

    def self.search(query)
      parsed_customers(
        CovaApi.customer.get("/Companies(#{CovaApi.company_id})/CustomerSearch?$filter=Criteria eq '#{query}'")
      ).map { |data| new raw: data }
    end

    def self.find(id)
      new raw: parsed_customer(
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

    attr_accessor :id, :first_name, :last_name, :birthday, :addresses, :contact_methods, :raw

    def initialize(id: nil, first_name: nil, last_name: nil, birthday: nil, addresses: [], contact_methods: [], raw: {})
      setup_raw(raw) unless raw.keys.size.zero?

      @id ||= id
      @first_name = first_name
      @last_name = last_name
      @birthday = birthday
      @addresses = addresses.map { |address| Address.new address }
      @contact_methods = contact_methods.map { |contact_method| ContactMethod.new contact_method }
    end

    def save
      raise AlreadyExists if id

      setup_raw parsed_customer(
        CovaApi.customer.post(
          "/Companies(#{CovaApi.company_id})/CustomerFull", {
            body: body_data.to_json,
            headers: {
              'Accept' => 'application/json',
              'Content-Type' => 'application/json'
            }
          }
        )
      )
      self
    end

    private

    def setup_raw(raw)
      @raw = raw
      @id = raw['Id']
    end

    def parsed_customer(result)
      Customer.send(:parsed_customer, result)
    end

    def body_data
      {
        'Addresses' => addresses.map(&:body_data),
        'ContactMethods' => contact_methods.map(&:body_data),
        'CustomerTypeId' => 2,
        'PrimaryName' => first_name,
        'FamilyName' => last_name,
        'DateOfBirth' => birthday,
        'Disabled' => false,
        'DoNotContact' => false
      }
    end

    def body_data_contact_method(type:, value:, default: false)
      type_map = contact_type_map(type)
      {
        'ContactMethodCategoryId' => type_map[:category_id],
        'ContactMethodTypeId' => type_map[:type_id],
        'Value' => value,
        'DoNotContact' => false,
        'Default' => default
      }
    end

    def contact_type_map(type)
      {
        category_id: type == :email ? 0 : 1,
        type_id: type == :email ? 0 : 1
      }
    end
  end
end
