require 'rails_helper'

describe 'Merchants API' do
  it 'sends revenue for an individual merchant' do
    merchant = create(:merchant)
    items = create_list(:item, 2, merchant_id: merchant.id)
    invoice = create(:invoice)
    create_list(:invoice_item, 2, item: items[0], invoice: invoice)
    create_list(:invoice_item, 3, item: items[1], invoice: invoice)
    create(:transaction, invoice: invoice)

    get "/api/v1/merchants/#{merchant.id}/revenue"

    expect(response).to be_success

    returned = JSON.parse(response.body)
    expected = '%.2f' % (merchant.total_revenue.to_f / 100)

    expect(returned['revenue']).to eq(expected)
  end
end
