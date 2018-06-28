require 'rails_helper'

describe 'Items API' do
  it 'returns the date with most sales' do
    item = create(:item)
    invoice1 = create(:invoice, created_at: '2012-03-12 05:54:09 UTC', status: 'shipped')
    invoice2 = create(:invoice, created_at: '2012-03-13 05:54:09 UTC', status: 'shipped')
    invoice3 = create(:invoice, created_at: '2012-03-11 05:54:09 UTC', status: 'shipped')
    create_list(:invoice_item, 4, item: item, invoice: invoice1, quantity: 3)
    create_list(:invoice_item, 4, item: item, invoice: invoice2, quantity: 3)
    create_list(:invoice_item, 2, item: item, invoice: invoice3, quantity: 3)

    get "/api/v1/items/#{item.id}/best_day"

    returned = JSON.parse(response.body)

    expect(returned['best_day']).to eq('2012-03-13T05:54:09.000Z')
  end
end
