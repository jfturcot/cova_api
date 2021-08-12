# frozen_string_literal: true

require 'oauth2'

RSpec.describe CovaApi::Endpoint::PointOfSale do
  it 'has a base url' do
    expect(CovaApi::Endpoint::PointOfSale::URL).to eq('https://api.covasoft.net')
  end

  it 'has a base prefix' do
    expect(CovaApi::Endpoint::PointOfSale::PREFIX).to eq('/pointofsale')
  end

  it 'extends CovaApi::Endpoint::Base' do
    expect(CovaApi::Endpoint::PointOfSale.is_a?(CovaApi::Endpoint::Base)).to be_truthy
  end
end
