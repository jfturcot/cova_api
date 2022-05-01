# frozen_string_literal: true

RSpec.describe CovaApi::Order::Status do
  let(:order_status_data) do
    {
      'CompanyId' => 1,
      'OrderId' => '39b5c289-8a8e-471a-bbc0-2909ebedbf81',
      'OrderStatus' => 0,
      'Message' => 'sample string 3'
    }
  end

  let(:order_status) { CovaApi::Order::Status.new(raw: order_status_data) }

  let(:oauth2_response) { OAuth2::Response.new(Faraday::Response.new) }

  before do
    allow(CovaApi).to receive(:company_id) { '123' }
    allow(CovaApi.sales_order).to receive(:get) { oauth2_response }
  end

  describe 'find' do
    before do
      allow(oauth2_response).to receive(:body) { order_status_data.to_json }
    end

    it 'calls the api' do
      expect(CovaApi.sales_order).to receive(:get).with('/Companies(123)/CovaOrder(987)/Status') { oauth2_response }
      CovaApi::Order::Status.find 987
    end

    it 'returns the order status' do
      results = CovaApi::Order::Status.find 987
      expect(results.id).to eq(order_status_data['OrderId'])
    end

    describe 'when order does not exist' do
      before do
        faraday_env = Faraday::Env.from(
          status: 404,
          body: '{"Message":"Resource cannot be found"}',
          response_headers: { 'Content-Type' => 'application/hal+json' }
        )
        faraday_response = Faraday::Response.new
        faraday_response.finish(faraday_env)
        error = OAuth2::Error.new OAuth2::Response.new(faraday_response)
        expect(CovaApi.sales_order).to receive(:get).with(
          '/Companies(123)/CovaOrder(987)/Status'
        ).and_raise(error)
      end

      it 'raise RecordNotFound' do
        expect { CovaApi::Order::Status.find(987) }.to raise_error(CovaApi::RecordNotFound)
      end
    end
  end

  it 'initializes id' do
    expect(order_status.id).to eq('39b5c289-8a8e-471a-bbc0-2909ebedbf81')
  end

  it 'initializes company_id' do
    expect(order_status.company_id).to eq(1)
  end

  it 'initializes status' do
    expect(order_status.status).to eq(0)
  end

  it 'initializes message' do
    expect(order_status.message).to eq('sample string 3')
  end
end
