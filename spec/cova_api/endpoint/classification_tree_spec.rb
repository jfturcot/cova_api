# frozen_string_literal: true

require 'oauth2'

RSpec.describe CovaApi::Endpoint::ClassificationTree do
  it 'has a base url' do
    expect(CovaApi::Endpoint::ClassificationTree::URL).to eq('https://productlibrary.iqmetrix.net')
  end

  it 'extends CovaApi::Endpoint::Base' do
    expect(CovaApi::Endpoint::ClassificationTree.is_a?(CovaApi::Endpoint::Base)).to be_truthy
  end
end
