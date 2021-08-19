# frozen_string_literal: true

module CovaApi
  class OrderPayment
    def self.body_data(payments)
      {
        'SaleID' => payments[:order_id],
        'CompanyId' => CovaApi.company_id,
        'TrackingNumber' => '',
        'Payments' => payments[:payments].map { |payment| new(payment).body_data }
      }
    end

    attr_accessor :pre_authorization_token, :amount, :time_taken_utc

    def initialize(pre_authorization_token:, amount:, time_taken_utc:)
      @pre_authorization_token = pre_authorization_token
      @amount = amount
      @time_taken_utc = time_taken_utc
    end

    def body_data
      {
        'PreAuthorizationToken' => pre_authorization_token,
        'Amount' => amount,
        'TimeTakenUtc' => time_taken_utc
      }
    end
  end
end
