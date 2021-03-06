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

    expect(response).to have_http_status(200)

    transaction = JSON.parse(response.body)

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

    expect(transaction['credit_card_number']).to eq(credit_card_num.to_s)
  end

  it 'can find all transactions from given params' do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    transactions = create_list(:transaction, 3, invoice: invoice, result: 'success')

    get "/api/v1/transactions/find_all?result=#{transactions[1].result}"

    expect(response).to have_http_status(200)

    returned = JSON.parse(response.body)

    expect(returned.count).to eq(3)
    returned.each do |transaction|
      expect(transaction['result']).to eq(transactions[1].result)
    end
  end

  it 'can return a random transaction' do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    create_list(:transaction, 3, invoice: invoice)

    get '/api/v1/transactions/random'

    expect(response).to have_http_status(200)

    transaction = JSON.parse(response.body)

    expect(transaction[0]['invoice_id']).to eq(invoice.id)
  end
end
