# frozen_string_literal: true

RSpec.describe CovaApi do
  it 'has a version number' do
    expect(CovaApi::VERSION).not_to be nil
  end

  before do
    CovaApi.authenticate(
      username: 'username',
      password: 'password',
      client_id: 'client_id',
      client_secret: 'client_secret',
      token_hash: {}
    )
  end

  describe '.catalog' do
    it 'returns CovaApi::Endpoint::Catalog' do
      expect(CovaApi.catalog).to eq(CovaApi::Endpoint::Catalog)
    end

    it 'runs CovaApi::Endpoint::Catalog class methods' do
      expect(CovaApi::Endpoint::Catalog).to receive(:get).with('/test')
      CovaApi.catalog.get('/test')
    end
  end

  describe '.classification_tree' do
    it 'returns CovaApi::Endpoint::ClassificationTree' do
      expect(CovaApi.classification_tree).to eq(CovaApi::Endpoint::ClassificationTree)
    end

    it 'runs CovaApi::Endpoint::ClassificationTree class methods' do
      expect(CovaApi::Endpoint::ClassificationTree).to receive(:get).with('/test')
      CovaApi.classification_tree.get('/test')
    end
  end

  describe '.company_tree' do
    it 'returns CovaApi::Endpoint::CompanyTree' do
      expect(CovaApi.company_tree).to eq(CovaApi::Endpoint::CompanyTree)
    end

    it 'runs CovaApi::Endpoint::CompanyTree class methods' do
      expect(CovaApi::Endpoint::CompanyTree).to receive(:get).with('/test')
      CovaApi.company_tree.get('/test')
    end
  end

  describe '.customer' do
    it 'returns CovaApi::Endpoint::Customer' do
      expect(CovaApi.customer).to eq(CovaApi::Endpoint::Customer)
    end

    it 'runs CovaApi::Endpoint::Customer class methods' do
      expect(CovaApi::Endpoint::Customer).to receive(:get).with('/test')
      CovaApi.customer.get('/test')
    end
  end

  describe '.dispensary' do
    it 'returns CovaApi::Endpoint::Dispensary' do
      expect(CovaApi.dispensary).to eq(CovaApi::Endpoint::Dispensary)
    end

    it 'runs CovaApi::Endpoint::Dispensary class methods' do
      expect(CovaApi::Endpoint::Dispensary).to receive(:get).with('/test')
      CovaApi.dispensary.get('/test')
    end
  end

  describe '.general_ledger' do
    it 'returns CovaApi::Endpoint::GeneralLedger' do
      expect(CovaApi.general_ledger).to eq(CovaApi::Endpoint::GeneralLedger)
    end

    it 'runs CovaApi::Endpoint::GeneralLedger class methods' do
      expect(CovaApi::Endpoint::GeneralLedger).to receive(:get).with('/test')
      CovaApi.general_ledger.get('/test')
    end
  end

  describe '.inventory_availability' do
    it 'returns CovaApi::Endpoint::InventoryAvailability' do
      expect(CovaApi.inventory_availability).to eq(CovaApi::Endpoint::InventoryAvailability)
    end

    it 'runs CovaApi::Endpoint::InventoryAvailability class methods' do
      expect(CovaApi::Endpoint::InventoryAvailability).to receive(:get).with('/test')
      CovaApi.inventory_availability.get('/test')
    end
  end

  describe '.item_pricing' do
    it 'returns CovaApi::Endpoint::ItemPricing' do
      expect(CovaApi.item_pricing).to eq(CovaApi::Endpoint::ItemPricing)
    end

    it 'runs CovaApi::Endpoint::ItemPricing class methods' do
      expect(CovaApi::Endpoint::ItemPricing).to receive(:get).with('/test')
      CovaApi.item_pricing.get('/test')
    end
  end

  describe '.loyalty_points' do
    it 'returns CovaApi::Endpoint::LoyaltyPoints' do
      expect(CovaApi.loyalty_points).to eq(CovaApi::Endpoint::LoyaltyPoints)
    end

    it 'runs CovaApi::Endpoint::LoyaltyPoints class methods' do
      expect(CovaApi::Endpoint::LoyaltyPoints).to receive(:get).with('/test')
      CovaApi.loyalty_points.get('/test')
    end
  end

  describe '.payment_method' do
    it 'returns CovaApi::Endpoint::PaymentMethod' do
      expect(CovaApi.payment_method).to eq(CovaApi::Endpoint::PaymentMethod)
    end

    it 'runs CovaApi::Endpoint::PaymentMethod class methods' do
      expect(CovaApi::Endpoint::PaymentMethod).to receive(:get).with('/test')
      CovaApi.payment_method.get('/test')
    end
  end

  describe '.point_of_sale' do
    it 'returns CovaApi::Endpoint::PointOfSale' do
      expect(CovaApi.point_of_sale).to eq(CovaApi::Endpoint::PointOfSale)
    end

    it 'runs CovaApi::Endpoint::PointOfSale class methods' do
      expect(CovaApi::Endpoint::PointOfSale).to receive(:get).with('/test')
      CovaApi.point_of_sale.get('/test')
    end
  end

  describe '.pos_reports' do
    it 'returns CovaApi::Endpoint::PosReports' do
      expect(CovaApi.pos_reports).to eq(CovaApi::Endpoint::PosReports)
    end

    it 'runs CovaApi::Endpoint::PosReports class methods' do
      expect(CovaApi::Endpoint::PosReports).to receive(:get).with('/test')
      CovaApi.pos_reports.get('/test')
    end
  end

  describe '.promotions' do
    it 'returns CovaApi::Endpoint::Promotions' do
      expect(CovaApi.promotions).to eq(CovaApi::Endpoint::Promotions)
    end

    it 'runs CovaApi::Endpoint::Promotions class methods' do
      expect(CovaApi::Endpoint::Promotions).to receive(:get).with('/test')
      CovaApi.promotions.get('/test')
    end
  end

  describe '.reason_codes' do
    it 'returns CovaApi::Endpoint::ReasonCodes' do
      expect(CovaApi.reason_codes).to eq(CovaApi::Endpoint::ReasonCodes)
    end

    it 'runs CovaApi::Endpoint::ReasonCodes class methods' do
      expect(CovaApi::Endpoint::ReasonCodes).to receive(:get).with('/test')
      CovaApi.reason_codes.get('/test')
    end
  end

  describe '.sales_invoice' do
    it 'returns CovaApi::Endpoint::SalesInvoice' do
      expect(CovaApi.sales_invoice).to eq(CovaApi::Endpoint::SalesInvoice)
    end

    it 'runs CovaApi::Endpoint::SalesInvoice class methods' do
      expect(CovaApi::Endpoint::SalesInvoice).to receive(:get).with('/test')
      CovaApi.sales_invoice.get('/test')
    end
  end

  describe '.sales_order' do
    it 'returns CovaApi::Endpoint::SalesOrder' do
      expect(CovaApi.sales_order).to eq(CovaApi::Endpoint::SalesOrder)
    end

    it 'runs CovaApi::Endpoint::SalesOrder class methods' do
      expect(CovaApi::Endpoint::SalesOrder).to receive(:get).with('/test')
      CovaApi.sales_order.get('/test')
    end
  end

  describe '.taxes' do
    it 'returns CovaApi::Endpoint::Taxes' do
      expect(CovaApi.taxes).to eq(CovaApi::Endpoint::Taxes)
    end

    it 'runs CovaApi::Endpoint::Taxes class methods' do
      expect(CovaApi::Endpoint::Taxes).to receive(:get).with('/test')
      CovaApi.taxes.get('/test')
    end
  end

  describe '.user_management' do
    it 'returns CovaApi::Endpoint::UserManagement' do
      expect(CovaApi.user_management).to eq(CovaApi::Endpoint::UserManagement)
    end

    it 'runs CovaApi::Endpoint::UserManagement class methods' do
      expect(CovaApi::Endpoint::UserManagement).to receive(:get).with('/test')
      CovaApi.user_management.get('/test')
    end
  end
end
