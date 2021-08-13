# frozen_string_literal: true

module CovaApi
  module Endpoint
    class InventoryAvailability
      extend Base

      def self.prefix
        '/availability/v1'
      end
    end
  end
end
