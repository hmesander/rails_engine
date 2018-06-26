require 'rails_helper'

describe "Items relationships API" do
  it 'returns all associated invoice_items' do
    item = create(:item)
    create_list(:invoice_items, 4, item:item)
    create_list(:invoice_items, 4)
    get "/api/v1/items/#{item.id}/invoice_items"

    invoice_items = JSON.parse(response.body)
    expect(invoice_items.count).to eq(4)
  end
  it 'should return all associated merchants' do
    item = create(:item)
    create_list(:merchants, 6, item:item)
    create_list(:merchants, 4)
    get "/api/v1/items/#{item.id}/merchants"

    merchants = JSON.parse(response.body)
    expect(merchants.count).to eq(6)
  end
end