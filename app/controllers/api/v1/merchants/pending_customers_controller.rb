class Api::V1::Merchants::PendingCustomersController < ApplicationController
  def index
    render json: Customer.pending_customers(params["id"])
  end
end