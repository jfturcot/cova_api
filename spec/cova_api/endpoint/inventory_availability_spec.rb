# frozen_string_literal: true

require 'oauth2'

RSpec.describe CovaApi::Endpoint::InventoryAvailability do
  it 'has a prefix' do
    expect(CovaApi::Endpoint::InventoryAvailability.prefix).to eq('/availability/v1')
  end

  it 'extends CovaApi::Endpoint::Base' do
    expect(CovaApi::Endpoint::InventoryAvailability.is_a?(CovaApi::Endpoint::Base)).to be_truthy
  end
end
