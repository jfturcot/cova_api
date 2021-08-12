# frozen_string_literal: true

require 'oauth2'

RSpec.describe CovaApi::Endpoint::Promotions do
  it 'has a base url' do
    expect(CovaApi::Endpoint::Promotions::URL).to eq('https://api.iqmetrix.net')
  end

  it 'has a base prefix' do
    expect(CovaApi::Endpoint::Promotions::PREFIX).to eq('/pospromotions/v1')
  end

  it 'extends CovaApi::Endpoint::Base' do
    expect(CovaApi::Endpoint::Promotions.is_a?(CovaApi::Endpoint::Base)).to be_truthy
  end
end
