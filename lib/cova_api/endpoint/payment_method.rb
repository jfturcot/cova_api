# frozen_string_literal: true

module CovaApi
  module Endpoint
    class PaymentMethod
      extend Base

      def self.prefix
        '/paymentmethods/v1'
      end
    end
  end
end
