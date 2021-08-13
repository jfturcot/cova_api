# frozen_string_literal: true

RSpec.describe CovaApi::Endpoint::PosReports do
  it 'has a prefix' do
    expect(CovaApi::Endpoint::PosReports.prefix).to eq('/posreports/v1')
  end

  it 'extends CovaApi::Endpoint::Base' do
    expect(CovaApi::Endpoint::PosReports.is_a?(CovaApi::Endpoint::Base)).to be_truthy
  end
end
