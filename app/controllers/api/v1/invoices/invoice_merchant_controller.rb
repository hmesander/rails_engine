class Api::V1::Invoices::InvoiceMerchantController < ApplicationController
  def index
    render json: Invoice.find(params[:id]).merchant
  end
end