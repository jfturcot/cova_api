# frozen_string_literal: true

module CovaApi
  module Endpoint
    class Catalog
      extend Base

      def self.prefix
        '/catalogs/v1'
      end
    end
  end
end
