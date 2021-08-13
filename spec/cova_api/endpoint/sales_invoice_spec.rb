# frozen_string_literal: true

RSpec.describe CovaApi::Endpoint::SalesInvoice do
  it 'has a url' do
    expect(CovaApi::Endpoint::SalesInvoice.url).to eq('https://invoice.iqmetrix.net')
  end

  it 'extends CovaApi::Endpoint::Base' do
    expect(CovaApi::Endpoint::SalesInvoice.is_a?(CovaApi::Endpoint::Base)).to be_truthy
  end
end
