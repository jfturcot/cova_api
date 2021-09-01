# frozen_string_literal: true

RSpec.describe CovaApi::Inventory do
  let(:inventory_data) do
    {
      'Id' => '02ce6e3c-b569-49f5-8da9-ffffffffffff',
      'EntityId' => 123456,
      'Quantity' => 11
    }
  end

  let(:inventory) { CovaApi::Inventory.new inventory_data }

  let(:oauth2_response) { OAuth2::Response.new(Faraday::Response.new) }

  before do
    allow(CovaApi).to receive(:company_id) { '123' }
  end

  describe '.by_location' do
    before do
      allow(oauth2_response).to receive(:parsed) { [inventory_data] }
      allow(oauth2_response).to receive(:body) { { '_embedded' => { 'self' => [inventory_data] } }.to_json }
      allow(CovaApi.inventory_availability).to receive(:get) { oauth2_response }
    end

    it 'calls the api' do
      expect(CovaApi.inventory_availability).to receive(:get).with(
        '/Companies(123)/Entities(987)/CatalogItems'
      ) { oauth2_response }
      CovaApi::Inventory.by_location 987
    end

    it 'returns the inventories' do
      results = CovaApi::Inventory.by_location 987
      expect(results.first.quantity).to eq(inventory_data['Quantity'])
    end
  end

  describe '.find_by' do
    before do
      allow(oauth2_response).to receive(:parsed) { [inventory_data] }
      allow(oauth2_response).to receive(:body) { { '_embedded' => { 'self' => inventory_data } }.to_json }
      allow(CovaApi.inventory_availability).to receive(:get) { oauth2_response }
    end

    it 'calls the api' do
      expect(CovaApi.inventory_availability).to receive(:get).with(
        '/Companies(123)/Entities(987)/CatalogItems(555)'
      ) { oauth2_response }
      CovaApi::Inventory.find_by location_id: 987, product_id: 555
    end

    it 'returns the inventories' do
      results = CovaApi::Inventory.find_by location_id: 987, product_id: 555
      expect(results.quantity).to eq(inventory_data['Quantity'])
    end

    describe 'when no inventory is available for the product' do
      before do
        faraday_env = Faraday::Env.from(
          status: 404,
          body: '{"Message":"Resource cannot be found"}',
          response_headers: { 'Content-Type' => 'application/hal+json' }
        )
        faraday_response = Faraday::Response.new
        faraday_response.finish(faraday_env)
        error = OAuth2::Error.new OAuth2::Response.new(faraday_response)
        expect(CovaApi.inventory_availability).to receive(:get).with(
          '/Companies(123)/Entities(987)/CatalogItems(555)'
        ).and_raise(error)
      end

      it 'returns an inventory of zero' do
        results = CovaApi::Inventory.find_by location_id: 987, product_id: 555
        expect(results.quantity).to eq(0)
      end
    end
  end

  it 'initializes product_id' do
    expect(inventory.product_id).to eq('02ce6e3c-b569-49f5-8da9-ffffffffffff')
  end

  it 'initializes location_id' do
    expect(inventory.location_id).to eq(123_456)
  end

  it 'initializes quantity' do
    expect(inventory.quantity).to eq(11)
  end

  it 'initializes data' do
    expect(inventory.data['Quantity']).to eq(11)
  end

  describe 'when no data is provided' do
    it 'creates an empty inventory' do
      empty_inventory = CovaApi::Inventory.new
      expect(empty_inventory.product_id).to be_nil
    end
  end
end
