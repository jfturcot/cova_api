# frozen_string_literal: true

module CovaApi
  module Endpoint
    module Base
      URL = 'https://api.covasoft.net'
      PREFIX = '/v1'

      VERBS = %w[get post put delete].freeze

      VERBS.each do |verb|
        define_method verb do |path, opts = {}|
          connection.send(verb, "#{PREFIX}#{path}", opts)
        end
      end

      private

      def connection
        CovaApi.connection(URL)
      end
    end
  end
end
