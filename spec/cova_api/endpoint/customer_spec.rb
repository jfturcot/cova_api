# frozen_string_literal: true

RSpec.describe CovaApi::Endpoint::Customer do
  it 'has a url' do
    expect(CovaApi::Endpoint::Customer.url).to eq('https://crm.iqmetrix.net')
  end

  it 'extends CovaApi::Endpoint::Base' do
    expect(CovaApi::Endpoint::Customer.is_a?(CovaApi::Endpoint::Base)).to be_truthy
  end
end
