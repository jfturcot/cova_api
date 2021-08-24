# frozen_string_literal: true

RSpec.describe CovaApi::Order do
  let(:order_data) do
    {
      entity_id: '123',
      first_name: 'John',
      last_name: 'Doe',
      customer_id: 'abc-123',
      items: [
        {
          name: 'Item name',
          catalog_item_id: '123-xxx',
          quantity: 2,
          price: 10.99
        }
      ]
    }
  end

  let(:order) { CovaApi::Order.new order_data }

  let(:payments) do
    {
      order_id: 'xxx-987',
      payments: [
        {
          pre_authorization_token: 'ccc-333',
          amount: 10.99,
          time_taken_utc: Time.now.utc.strftime('%Y-%m-%dT%H:%M:%S.%L%z')
        }
      ]
    }
  end

  let(:oauth2_response) { OAuth2::Response.new(Faraday::Response.new) }

  before do
    allow(CovaApi).to receive(:company_id) { '123' }
    allow(CovaApi.sales_order).to receive(:post) { oauth2_response }
  end

  it 'initializes id' do
    order_data.merge!(id: '987')
    expect(order.id).to eq('987')
  end

  it 'initializes entity_id' do
    expect(order.entity_id).to eq('123')
  end

  it 'initializes first_name' do
    expect(order.first_name).to eq('John')
  end

  it 'initializes last_name' do
    expect(order.last_name).to eq('Doe')
  end

  it 'initializes customer_id' do
    expect(order.customer_id).to eq('abc-123')
  end

  it 'initializes items' do
    expect(order.items.first.name).to eq('Item name')
  end

  it 'initializes taxes' do
    order_data.merge!(taxes: [{ tax_id: 'xxx-123', amount: 1.22 }])
    expect(order.taxes.first.tax_id).to eq('xxx-123')
  end

  it 'initializes discount' do
    order_data.merge!(discount: [{ type: 'InvoiceLevel', value: [{ name: 'Test', value: 1, value_type: 1 }] }])
    expect(order.discount.first[:type]).to eq('InvoiceLevel')
  end

  it 'initializes is_delivery' do
    expect(order.is_delivery).to eq(false)
  end

  describe '#save' do
    before do
      allow(oauth2_response).to receive(:parsed) { order_data.merge({ 'id' => '987' }) }
    end

    it 'calls the api' do
      expect(CovaApi.sales_order).to receive(:post).with(
        '/CovaOrder',
        {
          body: order.send(:body_data).to_json,
          headers: {
            'Accept' => 'application/json',
            'Content-Type' => 'application/json'
          }
        }
      ) { oauth2_response }
      order.save
    end

    it 'returns the saved order' do
      results = order.save
      expect(results.id).to eq('987')
    end

    it 'raises AlreadyExists if id is set' do
      order.id = '987'
      expect { order.save }.to raise_error(CovaApi::AlreadyExists)
    end
  end

  describe '#add_payments!' do
    it 'raises RecordNotFound if id is not set' do
      expect { order.add_payments!(payments) }.to raise_error(CovaApi::RecordNotFound)
    end

    it 'calls the api' do
      order.id = '987'
      expect(CovaApi.sales_order).to receive(:post).with(
        '/CovaOrderPayment',
        {
          body: CovaApi::Order::Payment.body_data(payments).to_json,
          headers: {
            'Accept' => 'application/json',
            'Content-Type' => 'application/json'
          }
        }
      ) { oauth2_response }
      order.add_payments! payments
    end
  end
end
