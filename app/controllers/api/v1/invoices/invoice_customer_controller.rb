class Api::V1::Invoices::InvoiceCustomerController < ApplicationController
  def index
    render json: Invoice.find(params[:id]).customer
  end
end