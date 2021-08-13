# frozen_string_literal: true

RSpec.describe CovaApi::Endpoint::CompanyTree do
  it 'has a url' do
    expect(CovaApi::Endpoint::CompanyTree.url).to eq('https://entitymanager.iqmetrix.net')
  end

  it 'extends CovaApi::Endpoint::Base' do
    expect(CovaApi::Endpoint::CompanyTree.is_a?(CovaApi::Endpoint::Base)).to be_truthy
  end
end
