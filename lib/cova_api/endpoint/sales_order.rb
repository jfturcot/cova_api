# frozen_string_literal: true

module CovaApi
  module Endpoint
    class SalesOrder
      extend Base

      def self.prefix
        '/covaorderintake/v1'
      end
    end
  end
end
