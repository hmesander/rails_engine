require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of items belonging to a merchant' do
    merchant = create(:merchant)
    create_list(:item, 5, merchant_id: merchant.id)

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to have_http_status(200)

    items = JSON.parse(response.body)

    expect(items.count).to eq(5)
  end

  it 'sends a list of invoices belonging to a merchant' do
    merchant = create(:merchant)
    customer = create(:customer)
    create_list(:invoice, 7, merchant_id: merchant.id, customer_id: customer.id)

    get "/api/v1/merchants/#{merchant.id}/invoices"

    expect(response).to have_http_status(200)

    invoices = JSON.parse(response.body)

    expect(invoices.count).to eq(7)
  end
end
