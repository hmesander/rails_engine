class Api::V1::Merchants::MerchantRevenueController < ApplicationController
  def show
    revenue = Merchant.find(params[:id]).total_revenue
    render json: { 'revenue' => money(revenue) }
  end
end
