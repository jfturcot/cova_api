# frozen_string_literal: true

require 'oauth2'

RSpec.describe CovaApi::Endpoint::Pricing do
  it 'has a base url' do
    expect(CovaApi::Endpoint::Pricing::URL).to eq('https://pricing.iqmetrix.net')
  end

  it 'extends CovaApi::Endpoint::Base' do
    expect(CovaApi::Endpoint::Pricing.is_a?(CovaApi::Endpoint::Base)).to be_truthy
  end
end
