# frozen_string_literal: true

require 'oauth2'

RSpec.describe CovaApi::Endpoint::Dispensary do
  it 'has a prefix' do
    expect(CovaApi::Endpoint::Dispensary.prefix).to eq('/dispensary')
  end

  it 'extends CovaApi::Endpoint::Base' do
    expect(CovaApi::Endpoint::Dispensary.is_a?(CovaApi::Endpoint::Base)).to be_truthy
  end
end
