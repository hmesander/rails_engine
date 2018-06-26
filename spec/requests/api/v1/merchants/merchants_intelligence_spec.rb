require 'rails_helper'

describe 'Merchants API' do
  it 'sends revenue for an individual merchant' do
    merchant = create(:merchant)
    customer = create(:customer)
    items = create_list(:item, 2, merchant: merchant)
    invoice = create(:invoice, merchant: merchant, customer: customer)
    create_list(:invoice_item, 2, item: items[0], invoice: invoice)
    create_list(:invoice_item, 3, item: items[1], invoice: invoice)
    create(:transaction, invoice: invoice)

    get "/api/v1/merchants/#{merchant.id}/revenue"

    expect(response).to have_http_status(200)

    returned = JSON.parse(response.body)
    expected = '%.2f' % (merchant.total_revenue / 100)

    expect(returned).to eq(expected)
  end
end
