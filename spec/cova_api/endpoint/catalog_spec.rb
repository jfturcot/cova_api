# frozen_string_literal: true

RSpec.describe CovaApi::Endpoint::Catalog do
  it 'has a prefix' do
    expect(CovaApi::Endpoint::Catalog.prefix).to eq('/catalogs/v1')
  end

  it 'extends CovaApi::Endpoint::Base' do
    expect(CovaApi::Endpoint::Catalog.is_a?(CovaApi::Endpoint::Base)).to be_truthy
  end
end
