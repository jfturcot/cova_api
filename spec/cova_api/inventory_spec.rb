# frozen_string_literal: true

RSpec.describe CovaApi::Location do
  let(:inventory_data) do
    {
      'Id' => '02ce6e3c-b569-49f5-8da9-ffffffffffff',
      'Quantity' => 11
    }
  end

  let(:inventory) { CovaApi::Inventory.new inventory_data }

  let(:oauth2_reponse) { OAuth2::Response.new(Faraday::Response.new) }

  before do
    allow(CovaApi).to receive(:company_id) { '123' }
  end

  describe '.by_location' do
    before do
      allow(oauth2_reponse).to receive(:parsed) { [inventory_data] }
      allow(oauth2_reponse).to receive(:body) { { '_embedded' => { 'self' => [inventory_data] } }.to_json }
      allow(CovaApi.inventory_availability).to receive(:get) { oauth2_reponse }
    end

    it 'calls the api' do
      expect(CovaApi.inventory_availability).to receive(:get).with(
        '/Companies(123)/Entities(987)/CatalogItems/SellingRoomOnly'
      ) { oauth2_reponse }
      CovaApi::Inventory.by_location 987
    end

    it 'returns the inventories' do
      results = CovaApi::Inventory.by_location 987
      expect(results.first.quantity).to eq(inventory_data['Quantity'])
    end
  end

  describe '.by_product_for_location' do
    before do
      allow(oauth2_reponse).to receive(:parsed) { [inventory_data] }
      allow(oauth2_reponse).to receive(:body) { { '_embedded' => { 'self' => inventory_data } }.to_json }
      allow(CovaApi.inventory_availability).to receive(:get) { oauth2_reponse }
    end

    it 'calls the api' do
      expect(CovaApi.inventory_availability).to receive(:get).with(
        '/Companies(123)/Entities(987)/CatalogItems(555)'
      ) { oauth2_reponse }
      CovaApi::Inventory.by_product_for_location location_id: 987, product_id: 555
    end

    it 'returns the inventories' do
      results = CovaApi::Inventory.by_product_for_location location_id: 987, product_id: 555
      expect(results.quantity).to eq(inventory_data['Quantity'])
    end
  end

  it 'initializes product_id' do
    expect(inventory.product_id).to eq('02ce6e3c-b569-49f5-8da9-ffffffffffff')
  end

  it 'initializes quantity' do
    expect(inventory.quantity).to eq(11)
  end

  it 'initializes data' do
    expect(inventory.data['Quantity']).to eq(11)
  end
end
