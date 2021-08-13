# frozen_string_literal: true

RSpec.describe CovaApi::Endpoint::SalesOrder do
  it 'has a base prefix' do
    expect(CovaApi::Endpoint::SalesOrder.prefix).to eq('/covaorderintake/v1')
  end

  it 'extends CovaApi::Endpoint::Base' do
    expect(CovaApi::Endpoint::SalesOrder.is_a?(CovaApi::Endpoint::Base)).to be_truthy
  end
end
