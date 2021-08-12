# frozen_string_literal: true

require 'oauth2'

RSpec.describe CovaApi::Endpoint::SaleInvoice do
  it 'has a base url' do
    expect(CovaApi::Endpoint::SaleInvoice::URL).to eq('https://invoice.iqmetrix.net')
  end

  it 'extends CovaApi::Endpoint::Base' do
    expect(CovaApi::Endpoint::SaleInvoice.is_a?(CovaApi::Endpoint::Base)).to be_truthy
  end
end
