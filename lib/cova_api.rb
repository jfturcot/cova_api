# frozen_string_literal: true

require 'cova_api/version'
require 'cova_api/authentication'
require 'cova_api/endpoint/base'
require 'cova_api/endpoint/catalog'
require 'cova_api/endpoint/classification_tree'
require 'cova_api/endpoint/company_tree'
require 'cova_api/endpoint/customers'
require 'cova_api/endpoint/dispensary'
require 'cova_api/endpoint/employees'
require 'cova_api/endpoint/inventory_availability'
require 'cova_api/endpoint/loyalty_points'
require 'cova_api/endpoint/orders'
require 'cova_api/endpoint/point_of_sale'
require 'cova_api/endpoint/pos_reports'
require 'cova_api/endpoint/pricing'
require 'cova_api/endpoint/promotions'
require 'cova_api/endpoint/sale_invoice'
require 'cova_api/endpoint/taxes'

module CovaApi
  class << self
    def api
      Endpoint::Api
    end

    def catalog
      Endpoint::Catalog
    end

    def classification_tree
      Endpoint::ClassificationTree
    end

    def company_tree
      Endpoint::CompanyTree
    end

    def customers
      Endpoint::Customers
    end

    def dispensary
      Endpoint::Dispensary
    end

    def employees
      Endpoint::Employees
    end

    def inventory_availability
      Endpoint::InventoryAvailability
    end

    def loyalty_points
      Endpoint::LoyaltyPoints
    end

    def orders
      Endpoint::Orders
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

    def sale_invoice
      Endpoint::SaleInvoice
    end

    def taxes
      Endpoint::Taxes
    end
  end
end
