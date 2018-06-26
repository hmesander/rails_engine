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

  it 'can get one transaction by its id' do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    transactions = create_list(:transaction, 3, invoice: invoice)
    id = transactions[1].id

    get "/api/v1/transactions/#{id}"

    transaction = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(transaction['id']).to eq(id)
  end

  it 'can find single transaction from given params' do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    transactions = create_list(:transaction, 3, invoice: invoice)
    credit_card_num = transactions[1].credit_card_number

    get "/api/v1/transactions/find?credit_card_number=#{credit_card_num}"
    expect(response).to have_http_status(200)

    transaction = JSON.parse(response.body)

    expect(transaction['credit_card_number']).to eq(credit_card_num)
  end
end
