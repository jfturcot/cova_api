# frozen_string_literal: true

RSpec.describe CovaApi::Customer do
  let(:customer_data) do
    {
      'Id' => 111,
      'PrimaryName' => 'Jeff'
    }
  end

  let(:customer) { CovaApi::Customer.new customer_data }

  let(:oauth2_reponse) { OAuth2::Response.new(Faraday::Response.new) }

  before do
    allow(CovaApi).to receive(:company_id) { '123' }
    allow(oauth2_reponse).to receive(:body) { { '_embedded' => { 'self' => [customer_data] } }.to_json }
    allow(CovaApi.customer).to receive(:get) { oauth2_reponse }
  end

  describe '.all' do
    it 'calls the api' do
      expect(CovaApi.customer).to receive(:get).with('/Companies(123)/Customers') { oauth2_reponse }
      CovaApi::Customer.all
    end

    it 'returns the customers' do
      results = CovaApi::Customer.all
      expect(results.first.data['PrimaryName']).to eq(customer_data['PrimaryName'])
    end
  end

  describe '.search' do
    it 'calls the api' do
      expect(CovaApi.customer).to(
        receive(:get).with("/Companies(123)/CustomerSearch?$filter=Criteria eq 'jeff@email.com'")
      ) do
        oauth2_reponse
      end
      CovaApi::Customer.search 'jeff@email.com'
    end

    it 'returns the customers' do
      results = CovaApi::Customer.search('jeff@email.com')
      expect(results.first.data['PrimaryName']).to eq(customer_data['PrimaryName'])
    end
  end

  it 'initializes id' do
    expect(customer.id).to eq(111)
  end

  it 'initializes data' do
    expect(customer.data['Id']).to eq(111)
  end
end
