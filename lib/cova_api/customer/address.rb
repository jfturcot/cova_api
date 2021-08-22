# frozen_string_literal: true

module CovaApi
  class Customer::Address
    attr_accessor :address1, :address2, :city, :state_code, :zip, :country_code, :phone, :email, :type, :default

    def initialize(
      address1:, city:, state_code:, zip:, country_code:, phone:, email:, address2: nil, type: 2, default: false
    )
      @address1 = address1
      @address2 = address2
      @city = city
      @state_code = state_code
      @zip = zip
      @country_code = country_code
      @phone = phone
      @email = email
      @type = type
      @default = default
    end

    def body_data
      {
        'AddressTypeId' => type,
        'Default' => default,
        'DoNotContact' => false,
        'CountryCode' => country_code,
        'Locality' => city,
        'StateCode' => state_code,
        'PostalCode' => zip,
        'StreetAddress1' => address1,
        'StreetAddress2' => address2,
        'Phone' => phone,
        'Email' => email
      }
    end
  end
end
