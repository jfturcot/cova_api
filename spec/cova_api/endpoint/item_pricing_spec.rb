# frozen_string_literal: true

require 'oauth2'

RSpec.describe CovaApi::Endpoint::ItemPricing do
  it 'has a prefix' do
    expect(CovaApi::Endpoint::ItemPricing.prefix).to eq('/pricing/v1')
  end

  it 'extends CovaApi::Endpoint::Base' do
    expect(CovaApi::Endpoint::ItemPricing.is_a?(CovaApi::Endpoint::Base)).to be_truthy
  end
end
