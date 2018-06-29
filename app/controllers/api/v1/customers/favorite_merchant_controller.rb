class Api::V1::Customers::FavoriteMerchantController < ApplicationController
  def show
    render json: Customer.find(params[:id]).favorite_merchant.first
  end
end
