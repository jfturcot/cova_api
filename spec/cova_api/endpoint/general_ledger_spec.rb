# frozen_string_literal: true

RSpec.describe CovaApi::Endpoint::GeneralLedger do
  it 'has a url' do
    expect(CovaApi::Endpoint::GeneralLedger.url).to eq('https://generalledger.iqmetrix.net')
  end

  it 'extends CovaApi::Endpoint::Base' do
    expect(CovaApi::Endpoint::GeneralLedger.is_a?(CovaApi::Endpoint::Base)).to be_truthy
  end
end
