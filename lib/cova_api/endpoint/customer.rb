# frozen_string_literal: true

module CovaApi
  module Endpoint
    class Customer
      extend Base

      def self.url
        'https://crm.iqmetrix.net'
      end
    end
  end
end
