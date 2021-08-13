# frozen_string_literal: true

module CovaApi
  module Endpoint
    class SalesInvoice
      extend Base

      def self.url
        'https://invoice.iqmetrix.net'
      end
    end
  end
end
