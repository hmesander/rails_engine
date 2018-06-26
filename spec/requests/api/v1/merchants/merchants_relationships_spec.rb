require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of items belonging to a merchant' do
    merchant = create(:merchant)
    create_list(:item, 5, merchant_id: merchant.id)

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to have_http_status(200)

    items = JSON.parse(response.body)

    expect(items.length).to eq(5)
    expect(response.body).to have_content(items[0].name)
  end
end
