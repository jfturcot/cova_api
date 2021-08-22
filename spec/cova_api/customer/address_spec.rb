# frozen_string_literal: true

RSpec.describe CovaApi::Customer::Address do
  let(:customer_address_data) do
    {
      address1: '123 Street',
      city: 'Montreal',
      state_code: 'QC',
      zip: 'X1X 1X1',
      country_code: 'CA',
      phone: '5141112222',
      email: 'jeff@example.com'
    }
  end

  let(:customer_address) { CovaApi::Customer::Address.new(customer_address_data) }

  it 'initializes address1' do
    expect(customer_address.address1).to eq('123 Street')
  end

  it 'initializes address2' do
    expect(customer_address.address2).to be_nil
  end

  it 'initializes city' do
    expect(customer_address.city).to eq('Montreal')
  end

  it 'initializes state_code' do
    expect(customer_address.state_code).to eq('QC')
  end

  it 'initializes zip' do
    expect(customer_address.zip).to eq('X1X 1X1')
  end

  it 'initializes country_code' do
    expect(customer_address.country_code).to eq('CA')
  end

  it 'initializes phone' do
    expect(customer_address.phone).to eq('5141112222')
  end

  it 'initializes email' do
    expect(customer_address.email).to eq('jeff@example.com')
  end

  it 'initializes type' do
    expect(customer_address.type).to eq(2)
  end

  it 'initializes default' do
    expect(customer_address.default).to be_falsey
  end

  describe '#body_data' do
    it 'builds the data' do
      expect(customer_address.body_data['StreetAddress1']).to eq('123 Street')
    end
  end
end
