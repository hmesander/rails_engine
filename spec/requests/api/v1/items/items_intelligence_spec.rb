require 'rails_helper'

describe 'Items API' do
  it 'returns the date with most sales' do
    item = create(:item)
    invoice1 = create(:invoice, created_at: '2012-03-12 05:54:09 UTC')
    invoice2 = create(:invoice, created_at: '2012-03-13 05:54:09 UTC')
    invoice3 = create(:invoice, created_at: '2012-03-11 05:54:09 UTC')
    create_list(:invoice_item, 4, item: item, invoice: invoice1)
    create_list(:invoice_item, 4, item: item, invoice: invoice2)
    create_list(:invoice_item, 2, item: item, invoice: invoice3)

    get "/api/v1/items/#{item.id}/best_day"

    returned = JSON.parse(response.body)

    expect(returned.count).to eq(1)
    expect(returned['date']).to eq(invoice2.created_at)
  end
end
