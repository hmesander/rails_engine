class Api::V1::Merchants::RevenueDateController < ApplicationController
  def show
    revenue = Merchant.total_rev_on_date(params["date"])
    render json: { 'revenue' => money(revenue) }
  end
end