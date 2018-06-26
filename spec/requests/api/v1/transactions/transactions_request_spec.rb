require 'rails_helper'

describe 'Transactions API' do
  it 'sends a list of transactions' do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    create_list(:transaction, 3, invoice: invoice)

    get '/api/v1/transactions'

    expect(response).to have_http_status(200)

    transactions = JSON.parse(response.body)

    expect(transactions.length).to eq(3)
  end
end
