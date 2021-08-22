# frozen_string_literal: true

RSpec.describe CovaApi::Customer::ContactMethod do
  let(:customer_contact_method_data) do
    {
      type: :email,
      value: 'jeff@example.com'
    }
  end

  let(:customer_contact_method) { CovaApi::Customer::ContactMethod.new(customer_contact_method_data) }

  it 'initializes type' do
    expect(customer_contact_method.type).to eq(:email)
  end

  it 'initializes value' do
    expect(customer_contact_method.value).to eq('jeff@example.com')
  end

  it 'initializes default' do
    expect(customer_contact_method.default).to be_falsey
  end

  describe '#body_data' do
    it 'builds the data' do
      expect(customer_contact_method.body_data['ContactMethodCategoryId']).to eq(2)
      expect(customer_contact_method.body_data['ContactMethodTypeId']).to eq(9)
      expect(customer_contact_method.body_data['Value']).to eq('jeff@example.com')
    end
  end
end
