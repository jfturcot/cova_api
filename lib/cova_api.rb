# frozen_string_literal: true

require 'cova_api/version'
require 'cova_api/customer'
require 'cova_api/customer/address'
require 'cova_api/customer/contact_method'
require 'cova_api/inventory'
require 'cova_api/location'
require 'cova_api/order'
require 'cova_api/order/discount'
require 'cova_api/order/item'
require 'cova_api/order/payment'
require 'cova_api/order/tax'
require 'cova_api/pricing'
require 'cova_api/product'
require 'cova_api/authentication'
require 'cova_api/endpoint/base'
require 'cova_api/endpoint/catalog'
require 'cova_api/endpoint/classification_tree'
require 'cova_api/endpoint/company_tree'
require 'cova_api/endpoint/customer'
require 'cova_api/endpoint/dispensary'
require 'cova_api/endpoint/general_ledger'
require 'cova_api/endpoint/inventory_availability'
require 'cova_api/endpoint/loyalty_points'
require 'cova_api/endpoint/payment_method'
require 'cova_api/endpoint/point_of_sale'
require 'cova_api/endpoint/pos_reports'
require 'cova_api/endpoint/pricing'
require 'cova_api/endpoint/promotions'
require 'cova_api/endpoint/reason_codes'
require 'cova_api/endpoint/sales_invoice'
require 'cova_api/endpoint/sales_order'
require 'cova_api/endpoint/taxes'
require 'cova_api/endpoint/user_management'

module CovaApi
  class RecordNotFound < StandardError; end

  class AlreadyExists < StandardError; end

  class << self
    def catalog
      Endpoint::Catalog
    end

    def classification_tree
      Endpoint::ClassificationTree
    end

    def company_tree
      Endpoint::CompanyTree
    end

    def customer
      Endpoint::Customer
    end

    def dispensary
      Endpoint::Dispensary
    end

    def general_ledger
      Endpoint::GeneralLedger
    end

    def inventory_availability
      Endpoint::InventoryAvailability
    end

    def loyalty_points
      Endpoint::LoyaltyPoints
    end

    def payment_method
      Endpoint::PaymentMethod
    end

    def point_of_sale
      Endpoint::PointOfSale
    end

    def pos_reports
      Endpoint::PosReports
    end

    def pricing
      Endpoint::Pricing
    end

    def promotions
      Endpoint::Promotions
    end

    def reason_codes
      Endpoint::ReasonCodes
    end

    def sales_invoice
      Endpoint::SalesInvoice
    end

    def sales_order
      Endpoint::SalesOrder
    end

    def taxes
      Endpoint::Taxes
    end

    def user_management
      Endpoint::UserManagement
    end
  end
end
