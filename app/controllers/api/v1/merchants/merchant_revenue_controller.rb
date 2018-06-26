class Api::V1::Merchants::MerchantRevenueController < ApplicationController
  def show
    render json: Merchant.find(params[:id]).format_revenue
  end
end
