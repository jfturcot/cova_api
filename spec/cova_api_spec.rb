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

  describe '.customers' do
    it 'returns CovaApi::Endpoint::Customers' do
      expect(CovaApi.customers).to eq(CovaApi::Endpoint::Customers)
    end

    it 'runs CovaApi::Endpoint::Customers class methods' do
      expect(CovaApi::Endpoint::Customers).to receive(:get).with('/test')
      CovaApi.customers.get('/test')
    end
  end

  describe '.customers' do
    it 'returns CovaApi::Endpoint::Customers' do
      expect(CovaApi.customers).to eq(CovaApi::Endpoint::Customers)
    end

    it 'runs CovaApi::Endpoint::Customers class methods' do
      expect(CovaApi::Endpoint::Customers).to receive(:get).with('/test')
      CovaApi.customers.get('/test')
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

  describe '.employees' do
    it 'returns CovaApi::Endpoint::Employees' do
      expect(CovaApi.employees).to eq(CovaApi::Endpoint::Employees)
    end

    it 'runs CovaApi::Endpoint::Employees class methods' do
      expect(CovaApi::Endpoint::Employees).to receive(:get).with('/test')
      CovaApi.employees.get('/test')
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

  describe '.loyalty_points' do
    it 'returns CovaApi::Endpoint::LoyaltyPoints' do
      expect(CovaApi.loyalty_points).to eq(CovaApi::Endpoint::LoyaltyPoints)
    end

    it 'runs CovaApi::Endpoint::LoyaltyPoints class methods' do
      expect(CovaApi::Endpoint::LoyaltyPoints).to receive(:get).with('/test')
      CovaApi.loyalty_points.get('/test')
    end
  end

  describe '.orders' do
    it 'returns CovaApi::Endpoint::Orders' do
      expect(CovaApi.orders).to eq(CovaApi::Endpoint::Orders)
    end

    it 'runs CovaApi::Endpoint::Orders class methods' do
      expect(CovaApi::Endpoint::Orders).to receive(:get).with('/test')
      CovaApi.orders.get('/test')
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

  describe '.pricing' do
    it 'returns CovaApi::Endpoint::Pricing' do
      expect(CovaApi.pricing).to eq(CovaApi::Endpoint::Pricing)
    end

    it 'runs CovaApi::Endpoint::Pricing class methods' do
      expect(CovaApi::Endpoint::Pricing).to receive(:get).with('/test')
      CovaApi.pricing.get('/test')
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

  describe '.sale_invoice' do
    it 'returns CovaApi::Endpoint::SaleInvoice' do
      expect(CovaApi.sale_invoice).to eq(CovaApi::Endpoint::SaleInvoice)
    end

    it 'runs CovaApi::Endpoint::SaleInvoice class methods' do
      expect(CovaApi::Endpoint::SaleInvoice).to receive(:get).with('/test')
      CovaApi.sale_invoice.get('/test')
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
end
