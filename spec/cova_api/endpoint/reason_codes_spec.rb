# frozen_string_literal: true

RSpec.describe CovaApi::Endpoint::ReasonCodes do
  it 'has a url' do
    expect(CovaApi::Endpoint::ReasonCodes.url).to eq('https://reasoncode.iqmetrix.net')
  end

  it 'extends CovaApi::Endpoint::Base' do
    expect(CovaApi::Endpoint::ReasonCodes.is_a?(CovaApi::Endpoint::Base)).to be_truthy
  end
end
