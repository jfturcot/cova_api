# frozen_string_literal: true

module CovaApi
  module Endpoint
    module Base
      VERBS = %w[get post put delete].freeze

      VERBS.each do |verb|
        define_method verb do |path, opts = {}|
          connection.send(verb, "#{prefix}#{path}", opts)
        end
      end

      def self.url
        'https://api.covasoft.net'
      end

      def self.prefix
        '/v1'
      end

      private

      def connection
        CovaApi.connection(url)
      end
    end
  end
end
