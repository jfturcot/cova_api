# frozen_string_literal: true

require 'oauth2'

RSpec.describe CovaApi::Endpoint::PosReports do
  it 'has a base url' do
    expect(CovaApi::Endpoint::PosReports::URL).to eq('https://posreports.iqmetrix.net')
  end

  it 'extends CovaApi::Endpoint::Base' do
    expect(CovaApi::Endpoint::PosReports.is_a?(CovaApi::Endpoint::Base)).to be_truthy
  end
end
