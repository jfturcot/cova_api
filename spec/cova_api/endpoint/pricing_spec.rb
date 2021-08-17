# frozen_string_literal: true

RSpec.describe CovaApi::Endpoint::Pricing do
  it 'has a prefix' do
    expect(CovaApi::Endpoint::Pricing.prefix).to eq('/pricing/v1')
  end

  it 'extends CovaApi::Endpoint::Base' do
    expect(CovaApi::Endpoint::Pricing.is_a?(CovaApi::Endpoint::Base)).to be_truthy
  end
end
