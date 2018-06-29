require 'rails_helper'

describe 'Items API' do
  it 'returns all associated invoice_items' do
    item = create(:item)
    create_list(:invoice_item, 4, item: item)
    create_list(:invoice_item, 4)

    get "/api/v1/items/#{item.id}/invoice_items"

    expect(response).to have_http_status(200)

    invoice_items = JSON.parse(response.body)

    expect(invoice_items.count).to eq(4)
  end

  it 'should return all associated merchants' do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)

    get "/api/v1/items/#{item.id}/merchant"

    expect(response).to have_http_status(200)

    returned_merchant = JSON.parse(response.body)

    expect(returned_merchant['name']).to eq(merchant.name)
    expect(returned_merchant['id']).to eq(merchant.id)
  end
end
