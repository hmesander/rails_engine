class Api::V1::Merchants::MostItemsController < ApplicationController
  def index
    render json: Merchant.rank_by_items(params[:quantity])
  end
end
