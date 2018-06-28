class Api::V1::Items::MostRevenueController < ApplicationController
  def show
    render json: Item.top_items(params["quantity"])
  end
end