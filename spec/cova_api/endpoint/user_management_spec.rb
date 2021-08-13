# frozen_string_literal: true

require 'oauth2'

RSpec.describe CovaApi::Endpoint::UserManagement do
  it 'has a url' do
    expect(CovaApi::Endpoint::UserManagement.url).to eq('https://usermanager.iqmetrix.net')
  end

  it 'extends CovaApi::Endpoint::Base' do
    expect(CovaApi::Endpoint::UserManagement.is_a?(CovaApi::Endpoint::Base)).to be_truthy
  end
end
