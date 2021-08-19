# frozen_string_literal: true

RSpec.describe CovaApi::OrderPayment do
  let(:order_payments_data) do
    {
      order_id: 'xxx-123',
      payments: [
        {
          pre_authorization_token: 'sss-234',
          amount: 9.99,
          time_taken_utc: Time.now.utc.strftime('%Y-%m-%dT%H:%M:%S.%L%z')
        }
      ]
    }
  end

  let(:order_payment) { CovaApi::OrderPayment.new(order_payments_data[:payments].first) }

  before do
    allow(CovaApi).to receive(:company_id) { '123' }
  end

  describe '.body_data' do
    it 'builds the data' do
      data = CovaApi::OrderPayment.body_data(order_payments_data)
      expect(data['SaleID']).to eq('xxx-123')
      expect(data['Payments'].first['PreAuthorizationToken']).to eq('sss-234')
    end
  end

  it 'initializes pre_authorization_token' do
    expect(order_payment.pre_authorization_token).to eq('sss-234')
  end

  it 'initializes amount' do
    expect(order_payment.amount).to eq(9.99)
  end

  it 'initializes time_taken_utc' do
    expect(order_payment.time_taken_utc).to eq(order_payments_data[:payments].first[:time_taken_utc])
  end

  describe '#body_data' do
    it 'builds the data' do
      expect(order_payment.body_data['PreAuthorizationToken']).to eq('sss-234')
    end
  end
end
