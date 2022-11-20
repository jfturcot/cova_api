# frozen_string_literal: true

RSpec.describe CovaApi::Product do
  let(:product_data) do
    {
      'CatalogItemId' => 234,
      'CatalogSku' => '2XXXXXXX',
      'DateAddedUtc' => '2022-01-30T16:09:44.017Z',
      'MasterProductId' => '98765'
    }
  end

  let(:product_2_data) do
    {
      'CatalogItemId' => 334,
      'CatalogSku' => '3XXXXXXX',
      'DateAddedUtc' => '2022-02-10T16:09:44.017Z',
      'MasterProductId' => '98765'
    }
  end

  let(:searched_product) do
    {
      'Name' => 'Redecan - Wappa Indica - 15g'
    }
  end

  let(:bulk_products) do
    {
      'CatalogItems' => {
        '234' => product_data,
        '334' => product_2_data
      }
    }
  end

  let(:structured_products) do
    {
      'Variations' => [],
      'Name' => 'Master Product',
      'Slug' => 'G123'
    }
  end

  let(:product) { CovaApi::Product.new product_data }
  let(:product2) { CovaApi::Product.new product_2_data }

  let(:oauth2_response) { OAuth2::Response.new(Faraday::Response.new) }

  before do
    allow(CovaApi).to receive(:company_id) { '123' }
    allow(CovaApi.catalog).to receive(:get) { oauth2_response }
    allow(CovaApi.catalog).to receive(:post) { oauth2_response }
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

  describe '.fetch' do
    before do
      allow(oauth2_response).to receive(:parsed) { bulk_products }
    end

    it 'calls the api' do
      expect(CovaApi.catalog).to receive(:post).with(
        '/Companies(123)/Catalog/Items/ProductDetails/Bulk',
        {
          body: { 'CatalogItemIds' => ['234', '334'] }.to_json,
          headers: {
            'Accept' => 'application/json',
            'Content-Type' => 'application/json'
          }
        }
      ) do
        oauth2_response
      end
      CovaApi::Product.fetch ['234', '334']
    end

    it 'returns the products' do
      results = CovaApi::Product.fetch ['234', '334']
      expect(results.first.data['DateAddedUtc']).to eq('2022-01-30T16:09:44.017Z')
      expect(results.first.data['MasterProductId']).to eq('98765')
      expect(results.last.data['DateAddedUtc']).to eq('2022-02-10T16:09:44.017Z')
      expect(results.last.data['MasterProductId']).to eq('98765')
    end

    it 'adds the id to the products' do
      results = CovaApi::Product.fetch ['234', '334']
      expect(results.first.id).to eq('234')
      expect(results.last.id).to eq('334')
    end
  end

  describe '.collection_for' do
    before do
      allow(oauth2_response).to receive(:parsed) { structured_products }
      allow(CovaApi::Product).to receive(:fetch) { [product, product2] }
    end

    it 'calls the api' do
      expect(CovaApi.catalog).to receive(:get).with('/Companies(123)/Catalog/Items(234)/Structure') { oauth2_response }
      CovaApi::Product.collection_for('234')
    end

    it 'returns the master product and its variants' do
      results = CovaApi::Product.collection_for('234')
      expect(results[:name]).to eq('Master Product')
      expect(results[:slug]).to eq('G123')
      expect(results[:variants].count).to eq(2)
    end

    it 'adds the sku to the master product' do
      results = CovaApi::Product.collection_for('234')
      expect(results[:sku]).to eq('98765')
    end
  end

  it 'initializes id' do
    expect(product.id).to eq(234)
  end

  it 'initializes data' do
    expect(product.data['CatalogItemId']).to eq(234)
  end

  describe 'when no data is provided' do
    it 'creates an empty product' do
      empty_product = CovaApi::Product.new
      expect(empty_product.id).to be_nil
    end
  end

  describe '#inventory_by_location' do
    it 'gets the inventory' do
      expect(CovaApi::Inventory).to receive(:find_by).with(product_id: 234, location_id: 987)
      product.inventory_by_location 987
    end
  end
end
