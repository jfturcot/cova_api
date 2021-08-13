# frozen_string_literal: true

require 'oauth2'

RSpec.describe CovaApi::Endpoint::PaymentMethod do
  it 'has a prefix' do
    expect(CovaApi::Endpoint::PaymentMethod.prefix).to eq('/paymentmethods/v1')
  end

  it 'extends CovaApi::Endpoint::Base' do
    expect(CovaApi::Endpoint::PaymentMethod.is_a?(CovaApi::Endpoint::Base)).to be_truthy
  end
end
