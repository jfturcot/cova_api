# frozen_string_literal: true

module CovaApi
  module Endpoint
    class Pricing
      extend Base

      def self.prefix
        '/pricing/v1'
      end
    end
  end
end
