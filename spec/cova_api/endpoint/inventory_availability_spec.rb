# frozen_string_literal: true

require 'oauth2'

RSpec.describe CovaApi::Endpoint::InventoryAvailability do
  it 'has a base url' do
    expect(CovaApi::Endpoint::InventoryAvailability::URL).to eq('https://api.covasoft.net')
  end

  it 'has a base prefix' do
    expect(CovaApi::Endpoint::InventoryAvailability::PREFIX).to eq('/availability/v1')
  end

  it 'extends CovaApi::Endpoint::Base' do
    expect(CovaApi::Endpoint::InventoryAvailability.is_a?(CovaApi::Endpoint::Base)).to be_truthy
  end
end
