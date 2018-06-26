class Api::V1::Merchants::MerchantRevenueController < ApplicationController
  def index
    render json: Merchant.total_revenue
  end
end
