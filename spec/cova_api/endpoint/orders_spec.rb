# frozen_string_literal: true

require 'oauth2'

RSpec.describe CovaApi::Endpoint::Orders do
  it 'has a base url' do
    expect(CovaApi::Endpoint::Orders::URL).to eq('https://api.iqmetrix.net')
  end

  it 'has a base prefix' do
    expect(CovaApi::Endpoint::Orders::PREFIX).to eq('/covaorderintake/v1')
  end

  it 'extends CovaApi::Endpoint::Base' do
    expect(CovaApi::Endpoint::Orders.is_a?(CovaApi::Endpoint::Base)).to be_truthy
  end
end
