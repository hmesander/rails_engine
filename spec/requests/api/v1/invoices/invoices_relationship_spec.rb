require 'rails_helper'

describe 'Invoices API' do
  it 'should return all associated transactions' do
    invoice = create(:invoice)
    create_list(:transaction, 4, invoice: invoice)
    create_list(:transaction, 4)

    get "/api/v1/invoices/#{invoice.id}/transactions"

    expect(response).to have_http_status(200)

    transactions = JSON.parse(response.body)

    expect(transactions.count).to eq(4)
  end

  it 'should return all associated invoice items' do
    invoice = create(:invoice)
    create_list(:invoice_item, 4, invoice: invoice)
    create_list(:invoice_item, 4)

    get "/api/v1/invoices/#{invoice.id}/invoice_items"

    expect(response).to have_http_status(200)

    invoice_items = JSON.parse(response.body)

    expect(invoice_items.count).to eq(4)
  end
  it 'should return all associated items' do
    invoice = create(:invoice)
    create_list(:item,10)
    4.times do |num|
      create(:invoice_item, invoice: invoice, item:Item.all[num])
    end

    get "/api/v1/invoices/#{invoice.id}/items"

    expect(response).to have_http_status(200)

    items = JSON.parse(response.body)

    expect(items.count).to eq(4)
  end

  it 'should return the associated customer' do
    customer = create(:customer)
    invoice = create(:invoice, customer: customer)

    get "/api/v1/invoices/#{invoice.id}/customer"

    expect(response).to have_http_status(200)

    returned_customer = JSON.parse(response.body)

    expect(returned_customer['first_name']).to eq(customer.first_name)
    expect(returned_customer['last_name']).to eq(customer.last_name)
  end

  it 'should return the associated merchant' do
    merchant = create(:merchant)
    invoice = create(:invoice, merchant: merchant)

    get "/api/v1/invoices/#{invoice.id}/merchant"

    expect(response).to have_http_status(200)

    returned_merchant = JSON.parse(response.body)

    expect(returned_merchant['name']).to eq(merchant.name)
  end
end
