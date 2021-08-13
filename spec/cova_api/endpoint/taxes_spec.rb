# frozen_string_literal: true

RSpec.describe CovaApi::Endpoint::Taxes do
  it 'has a url' do
    expect(CovaApi::Endpoint::Taxes.url).to eq('https://iqtaxprovider.iqmetrix.net')
  end

  it 'extends CovaApi::Endpoint::Base' do
    expect(CovaApi::Endpoint::Taxes.is_a?(CovaApi::Endpoint::Base)).to be_truthy
  end
end
