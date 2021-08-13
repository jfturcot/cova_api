# frozen_string_literal: true

require 'oauth2'

RSpec.describe CovaApi::Endpoint::Promotions do
  it 'has a prefix' do
    expect(CovaApi::Endpoint::Promotions.prefix).to eq('/pospromotions/v2')
  end

  it 'extends CovaApi::Endpoint::Base' do
    expect(CovaApi::Endpoint::Promotions.is_a?(CovaApi::Endpoint::Base)).to be_truthy
  end
end
