# frozen_string_literal: true

RSpec.describe CovaApi::Customer do
  let(:customer_data) do
    {
      'Id' => 111,
      'PrimaryName' => 'Jeff',
    }
  end

  let(:customer) { CovaApi::Customer.new raw: customer_data }

  let(:new_customer) do
    CovaApi::Customer.new(
      first_name: 'Jeff',
      last_name: nil,
      birthday: '1996-08-21T17:15:43+00:00',
      addresses: [
        {
          address1: '123 Street',
          city: 'Montreal',
          state_code: 'QC',
          zip: 'X1X 1X1',
          country_code: 'CA',
          phone: '5141112222',
          email: 'jeff@example.com'
        }
      ],
      contact_methods: [
        {
          type: :email,
          value: 'jeff@example.com',
          default: true
        },
        {
          type: :phone,
          value: '5141112222'
        }
      ]
    )
  end

  let(:oauth2_response) { OAuth2::Response.new(Faraday::Response.new) }

  before do
    allow(CovaApi).to receive(:company_id) { '123' }
    allow(CovaApi.customer).to receive(:get) { oauth2_response }
  end

  describe '.all' do
    before do
      allow(oauth2_response).to receive(:body) { { '_embedded' => { 'self' => [customer_data] } }.to_json }
    end

    it 'calls the api' do
      expect(CovaApi.customer).to receive(:get).with('/Companies(123)/Customers') { oauth2_response }
      CovaApi::Customer.all
    end

    it 'returns the customers' do
      results = CovaApi::Customer.all
      expect(results.first.raw['PrimaryName']).to eq(customer_data['PrimaryName'])
    end
  end

  describe '.search' do
    describe 'when customers are returned' do
      before do
        allow(oauth2_response).to receive(:body) { { '_embedded' => { 'self' => [customer_data] } }.to_json }
      end

      it 'calls the api' do
        expect(CovaApi.customer).to(
          receive(:get).with("/Companies(123)/CustomerSearch?$filter=Criteria eq 'jeff@email.com'")
        ) do
          oauth2_response
        end
        CovaApi::Customer.search 'jeff@email.com'
      end

      it 'returns the customers' do
        results = CovaApi::Customer.search('jeff@email.com')
        expect(results.first.raw['PrimaryName']).to eq(customer_data['PrimaryName'])
      end
    end

    describe 'when no customers is returned' do
      before do
        allow(oauth2_response).to receive(:body) { { '_embedded' => {} }.to_json }
      end

      it 'returns no customers' do
        results = CovaApi::Customer.search('jeff@email.com')
        expect(results.size).to eq(0)
      end
    end
  end

  describe 'find' do
    before do
      allow(oauth2_response).to receive(:body) { customer_data.to_json }
    end

    it 'calls the api' do
      expect(CovaApi.customer).to receive(:get).with('/Companies(123)/CustomerFull(987)') { oauth2_response }
      CovaApi::Customer.find 987
    end

    it 'returns the customer' do
      results = CovaApi::Customer.find 987
      expect(results.id).to eq(customer_data['Id'])
    end

    describe 'when customer does not exist' do
      before do
        faraday_env = Faraday::Env.from(
          status: 404,
          body: '{"Message":"Resource cannot be found"}',
          response_headers: { 'Content-Type' => 'application/hal+json' }
        )
        faraday_response = Faraday::Response.new
        faraday_response.finish(faraday_env)
        error = OAuth2::Error.new OAuth2::Response.new(faraday_response)
        expect(CovaApi.customer).to receive(:get).with(
          '/Companies(123)/CustomerFull(987)'
        ).and_raise(error)
      end

      it 'raise RecordNotFound' do
        expect { CovaApi::Customer.find(987) }.to raise_error(CovaApi::RecordNotFound)
      end
    end
  end

  it 'initializes id' do
    expect(customer.id).to eq(111)
  end

  it 'initializes raw' do
    expect(customer.raw['Id']).to eq(111)
  end

  describe 'when no raw data is provided' do
    it 'creates an empty customer' do
      empty_customer = CovaApi::Customer.new
      expect(empty_customer.id).to be_nil
    end
  end

  describe '#save' do
    before do
      allow(oauth2_response).to receive(:body) { customer_data.merge({ 'Id' => '987' }).to_json }
      allow(CovaApi.customer).to receive(:post) { oauth2_response }
    end

    it 'calls the api' do
      expect(CovaApi.customer).to receive(:post).with(
        '/Companies(123)/CustomerFull',
        {
          body: new_customer.send(:body_data).to_json,
          headers: {
            'Accept' => 'application/json',
            'Content-Type' => 'application/json'
          }
        }
      ) { oauth2_response }
      new_customer.save
    end

    it 'returns the saved customer' do
      results = new_customer.save
      expect(results.id).to eq('987')
    end

    it 'raises AlreadyExists if id is set' do
      expect { customer.save }.to raise_error(CovaApi::AlreadyExists)
    end
  end
end
