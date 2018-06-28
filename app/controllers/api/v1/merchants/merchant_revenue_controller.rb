class Api::V1::Merchants::MerchantRevenueController < ApplicationController
  def show
    revenue = Merchant.find(params[:id]).total_revenue(query_params)
    render json: { 'revenue' => money(revenue) }
  end

  def index
    render json: Merchant.top_merchants(params["quantity"])
  end

  private

  def query_params
    if params[:date]
      day = Date.parse(params[:date])
      { invoices: { created_at: day.beginning_of_day..day.end_of_day } }
    end
  end
end
