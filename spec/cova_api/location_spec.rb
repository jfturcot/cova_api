# frozen_string_literal: true

RSpec.describe CovaApi::Location do
  let(:location_data) do
    {
      'Id' => 987,
      'Name' => 'Main Location'
    }
  end

  let(:location) { CovaApi::Location.new location_data }

  let(:inventory_data) do
    {
      'Id' => '02ce6e3c-b569-49f5-8da9-ffffffffffff',
      'Quantity' => 11
    }
  end

  let(:oauth2_reponse) { OAuth2::Response.new(Faraday::Response.new) }

  before do
    allow(CovaApi).to receive(:company_id) { '123' }
  end

  describe '.all' do
    before do
      allow(oauth2_reponse).to receive(:parsed) { [location_data] }
      allow(CovaApi.company_tree).to receive(:get) { oauth2_reponse }
    end

    it 'calls the api' do
      expect(CovaApi.company_tree).to receive(:get).with('/Companies(123)/Locations') { oauth2_reponse }
      CovaApi::Location.all
    end

    it 'returns the locations' do
      results = CovaApi::Location.all
      expect(results.first.data['Name']).to eq(location_data['Name'])
    end
  end

  it 'initializes id' do
    expect(location.id).to eq(987)
  end

  it 'initializes data' do
    expect(location.data['Name']).to eq('Main Location')
  end

  describe '#inventory' do
    it 'gets the inventory' do
      expect(CovaApi::Inventory).to receive(:by_location).with(987)
      location.inventory
    end
  end
end
