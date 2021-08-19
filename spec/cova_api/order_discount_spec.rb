# frozen_string_literal: true

RSpec.describe CovaApi::OrderDiscount do
  let(:order_discounts_data) do
    [
      {
        type: 'InvoiceLevel',
        value: [
          { name: 'Test', value: 1, value_type: 2 }
        ]
      },
      {
        type: 'Percentage',
        value: 10
      }
    ]
  end

  let(:order_discount) { CovaApi::OrderDiscount.new(order_discounts_data.first[:value].first) }

  describe '.body_data' do
    it 'builds the data' do
      data = CovaApi::OrderDiscount.body_data(order_discounts_data)
      expect(data['Discount']['InvoiceLevel'].first['Name']).to eq('Test')
      expect(data['Discount']['Percentage']).to eq(10)
    end
  end

  it 'initializes name' do
    expect(order_discount.name).to eq('Test')
  end

  it 'initializes value' do
    expect(order_discount.value).to eq(1)
  end

  it 'initializes value_type' do
    expect(order_discount.value_type).to eq(2)
  end

  describe '#body_data' do
    it 'builds the data' do
      expect(order_discount.body_data['Name']).to eq('Test')
    end
  end
end
