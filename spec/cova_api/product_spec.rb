# frozen_string_literal: true

RSpec.describe CovaApi::Product do
  let(:product_data) do
    {
      'CatalogItemId' => 234,
      'CatalogSku' => '2XXXXXXX'
    }
  end

  let(:searched_product) do
    {
      'Name' => 'Redecan - Wappa Indica - 15g'
    }
  end

  let(:product) { CovaApi::Product.new product_data }

  let(:oauth2_response) { OAuth2::Response.new(Faraday::Response.new) }

  before do
    allow(CovaApi).to receive(:company_id) { '123' }
    allow(CovaApi.catalog).to receive(:get) { oauth2_response }
  end

  describe '.all' do
    before do
      allow(oauth2_response).to receive(:parsed) { [product_data] }
    end

    it 'calls the api' do
      expect(CovaApi.catalog).to receive(:get).with('/Companies(123)/Catalog/Items') { oauth2_response }
      CovaApi::Product.all
    end

    it 'returns the products' do
      results = CovaApi::Product.all
      expect(results.first.data['CatalogSku']).to eq(product_data['CatalogSku'])
    end
  end

  describe '.search' do
    before do
      allow(oauth2_response).to receive(:parsed) { { 'Items' => [searched_product] } }
    end

    it 'calls the api' do
      expect(CovaApi.catalog).to receive(:get).with('/Companies(123)/Catalog/Search?SearchTerms=test123') do
        oauth2_response
      end
      CovaApi::Product.search 'test123'
    end

    it 'returns the products' do
      results = CovaApi::Product.search('test123')
      expect(results.first.data['Name']).to eq(searched_product['Name'])
    end
  end

  describe '.find' do
    before do
      allow(oauth2_response).to receive(:parsed) { searched_product }
    end

    it 'calls the api' do
      expect(CovaApi.catalog).to receive(:get).with('/Companies(123)/Catalog/Items(aabb-1234)/ProductDetails') do
        oauth2_response
      end
      CovaApi::Product.find 'aabb-1234'
    end

    it 'returns the product' do
      results = CovaApi::Product.find 'aabb-1234'
      expect(results.data['Name']).to eq(searched_product['Name'])
    end

    it 'adds the id to the product' do
      results = CovaApi::Product.find 'aabb-1234'
      expect(results.id).to eq('aabb-1234')
    end
  end

  it 'initializes id' do
    expect(product.id).to eq(234)
  end

  it 'initializes data' do
    expect(product.data['CatalogItemId']).to eq(234)
  end

  describe '#inventory_by_location' do
    it 'gets the inventory' do
      expect(CovaApi::Inventory).to receive(:find_by).with(product_id: 234, location_id: 987)
      product.inventory_by_location 987
    end
  end
end
