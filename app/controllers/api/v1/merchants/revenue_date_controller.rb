class Api::V1::Merchants::RevenueDateController < ApplicationController
  def show
    revenue = Merchant.total_rev_on_date(params["date"])
    render json: { 'total_revenue' => money(revenue) }
  end
end
