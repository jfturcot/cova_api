# frozen_string_literal: true

require 'oauth2'

RSpec.describe CovaApi::Endpoint::LoyaltyPoints do
  it 'has a base url' do
    expect(CovaApi::Endpoint::LoyaltyPoints::URL).to eq('https://iqloyalty.iqmetrix.net')
  end

  it 'extends CovaApi::Endpoint::Base' do
    expect(CovaApi::Endpoint::LoyaltyPoints.is_a?(CovaApi::Endpoint::Base)).to be_truthy
  end
end
