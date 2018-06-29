require 'rails_helper'

describe 'Customers API' do
  it 'sends a list of invoices belonging to a customer' do
    customer = create(:customer)
    create_list(:invoice, 5, customer: customer)

    get "/api/v1/customers/#{customer.id}/invoices"

    expect(response).to have_http_status(200)

    invoices = JSON.parse(response.body)

    expect(invoices.count).to eq(5)
  end

  it 'sends a list of transactions belonging to a customer' do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, merchant: merchant, customer: customer)
    create_list(:transaction, 5, invoice: invoice)
    create_list(:transaction, 10)

    get "/api/v1/customers/#{customer.id}/transactions"

    expect(response).to have_http_status(200)

    transactions = JSON.parse(response.body)

    expect(transactions.count).to eq(5)
  end
end
