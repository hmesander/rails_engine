class Api::V1::Items::RevenueController < ApplicationController
  def show
    render json: Item.top_items(params["quantity"])
  end
end
