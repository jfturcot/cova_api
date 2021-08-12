# frozen_string_literal: true

require 'oauth2'

RSpec.describe CovaApi::Endpoint::Customers do
  it 'has a base url' do
    expect(CovaApi::Endpoint::Customers::URL).to eq('https://crm.iqmetrix.net')
  end

  it 'extends CovaApi::Endpoint::Base' do
    expect(CovaApi::Endpoint::Customers.is_a?(CovaApi::Endpoint::Base)).to be_truthy
  end
end
