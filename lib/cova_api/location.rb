# frozen_string_literal: true

module CovaApi
  class Location
    def self.all
      result = CovaApi.company_tree.get("/Companies(#{CovaApi.company_id})/Locations")
      result.parsed.map { |data| new(data) }
    end

    attr_accessor :data, :id

    def initialize(data)
      @data = data
      @id = data['Id']
    end

    def inventory
      CovaApi::Location.by_location id
    end
  end
end
