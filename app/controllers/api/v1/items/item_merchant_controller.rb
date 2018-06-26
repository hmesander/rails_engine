class Api::V1::Items::ItemMerchantController < ApplicationController
  def index
    render json: Item.find(params[:id]).merchant
  end
end