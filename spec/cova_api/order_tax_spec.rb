# frozen_string_literal: true

RSpec.describe CovaApi::OrderTax do
  let(:order_tax_data) do
    {
      tax_id: 'tx-01',
      amount: 9.97
    }
  end

  let(:order_tax) { CovaApi::OrderTax.new(order_tax_data) }

  it 'initializes tax_id' do
    expect(order_tax.tax_id).to eq('tx-01')
  end

  it 'initializes amount' do
    expect(order_tax.amount).to eq(9.97)
  end

  describe '#body_data' do
    it 'builds the data' do
      expect(order_tax.body_data['TaxId']).to eq('tx-01')
    end
  end
end
