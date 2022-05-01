# frozen_string_literal: true

module CovaApi
  class Order::Status
    def self.find(id)
      new raw: parsed_order_status(
        CovaApi.sales_order.get("/Companies(#{CovaApi.company_id})/CovaOrder(#{id})/Status")
      )
    rescue OAuth2::Error => e
      message = e.message && JSON.parse(e.message)
      raise unless message && message['Message'] == 'Resource cannot be found'

      raise RecordNotFound
    end

    private_class_method def self.parsed_order_status(result)
      JSON.parse result.body
    end

    attr_accessor :id, :company_id, :status, :message, :raw

    def initialize(id: nil, company_id: nil, status: nil, message: nil, raw: {})
      setup_raw(raw) unless raw.keys.size.zero?

      @id ||= id
      @company_id ||= company_id
      @status ||= status
      @message ||= message
    end

    private

    def setup_raw(raw)
      @raw = raw
      @id = raw['OrderId']
      @company_id = raw['CompanyId']
      @status = raw['OrderStatus']
      @message = raw['Message']
    end
  end
end
