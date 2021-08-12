# frozen_string_literal: true

require 'oauth2'

RSpec.describe CovaApi::Endpoint::Employees do
  it 'has a base url' do
    expect(CovaApi::Endpoint::Employees::URL).to eq('https://usermanager.iqmetrix.net')
  end

  it 'extends CovaApi::Endpoint::Base' do
    expect(CovaApi::Endpoint::Employees.is_a?(CovaApi::Endpoint::Base)).to be_truthy
  end
end
