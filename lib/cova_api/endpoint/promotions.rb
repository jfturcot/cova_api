# frozen_string_literal: true

module CovaApi
  module Endpoint
    class Promotions
      extend Base

      def self.prefix
        '/pospromotions/v2'
      end
    end
  end
end
