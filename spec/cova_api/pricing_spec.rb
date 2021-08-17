# frozen_string_literal: true

RSpec.describe CovaApi::Pricing do
  let(:pricing_data) do
    {
      'CatalogItemId' => '02ce6e3c-b569-49f5-8da9-ffffffffffff',
      'EntityId' => 123456,
      'RegularPrice' => 11.99
    }
  end

  let(:pricing) { CovaApi::Pricing.new pricing_data }

  let(:oauth2_response) { OAuth2::Response.new(Faraday::Response.new) }

  before do
    allow(CovaApi).to receive(:company_id) { '123' }
  end

  describe '.by_location' do
    before do
      allow(oauth2_response).to receive(:parsed) { [pricing_data] }
      allow(oauth2_response).to receive(:body) { { '_embedded' => { 'self' => [pricing_data] } }.to_json }
      allow(CovaApi.pricing).to receive(:get) { oauth2_response }
    end

    it 'calls the api' do
      expect(CovaApi.pricing).to receive(:get).with(
        '/Companies(123)/Entities(987)/CatalogItems'
      ) { oauth2_response }
      CovaApi::Pricing.by_location 987
    end

    it 'returns the pricings' do
      results = CovaApi::Pricing.by_location 987
      expect(results.first.price).to eq(pricing_data['RegularPrice'])
    end
  end

  describe '.find_by' do
    before do
      allow(oauth2_response).to receive(:parsed) { [pricing_data] }
      allow(oauth2_response).to receive(:body) { { '_embedded' => { 'self' => [pricing_data] } }.to_json }
      allow(CovaApi.pricing).to receive(:get) { oauth2_response }
    end

    it 'calls the api' do
      expect(CovaApi.pricing).to receive(:get).with(
        '/Companies(123)/Entities(987)/CatalogItems(555)/Pricing'
      ) { oauth2_response }
      CovaApi::Pricing.find_by location_id: 987, product_id: 555
    end

    it 'returns the pricing' do
      results = CovaApi::Pricing.find_by location_id: 987, product_id: 555
      expect(results.price).to eq(pricing_data['RegularPrice'])
    end
  end

  it 'initializes product_id' do
    expect(pricing.product_id).to eq('02ce6e3c-b569-49f5-8da9-ffffffffffff')
  end

  it 'initializes location_id' do
    expect(pricing.location_id).to eq(123_456)
  end

  it 'initializes price' do
    expect(pricing.price).to eq(11.99)
  end

  it 'initializes data' do
    expect(pricing.data['RegularPrice']).to eq(11.99)
  end
end
