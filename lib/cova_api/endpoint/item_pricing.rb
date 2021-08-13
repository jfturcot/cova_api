# frozen_string_literal: true

module CovaApi
  module Endpoint
    class ItemPricing
      extend Base

      def self.prefix
        '/pricing/v1'
      end
    end
  end
end
