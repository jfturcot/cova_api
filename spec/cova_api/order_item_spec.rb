# frozen_string_literal: true

RSpec.describe CovaApi::OrderItem do
  let(:order_item_data) do
    {
      name: 'Item name',
      catalog_item_id: 'abc-123',
      quantity: 2,
      price: 9.99
    }
  end

  let(:order_item) { CovaApi::OrderItem.new(order_item_data) }

  it 'initializes name' do
    expect(order_item.name).to eq('Item name')
  end

  it 'initializes catalog_item_id' do
    expect(order_item.catalog_item_id).to eq('abc-123')
  end

  it 'initializes quantity' do
    expect(order_item.quantity).to eq(2)
  end

  it 'initializes price' do
    expect(order_item.price).to eq(9.99)
  end

  describe '#body_data' do
    it 'builds the data' do
      expect(order_item.body_data['Name']).to eq('Item name')
    end
  end
end
