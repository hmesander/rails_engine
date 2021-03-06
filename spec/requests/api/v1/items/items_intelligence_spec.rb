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

    expect(response).to have_http_status(200)

    returned = JSON.parse(response.body)

    expect(returned['best_day']).to eq('2012-03-13T05:54:09.000Z')
  end

  it 'returns the top items ranked by amount sold' do
    items = create_list(:item, 5)
    invoice = create(:invoice)
    create_list(:invoice_item, 4, item: items[2], invoice: invoice, quantity: 10)
    create_list(:invoice_item, 4, item: items[1], invoice: invoice, quantity: 5)
    create_list(:invoice_item, 2, item: items[4], invoice: invoice, quantity: 100)

    get '/api/v1/items/most_items?quantity=3'

    expect(response).to have_http_status(200)

    returned = JSON.parse(response.body)

    expect(returned[0]['name']).to eq(items[4].name)
    expect(returned[1]['name']).to eq(items[2].name)
    expect(returned[2]['name']).to eq(items[1].name)
  end

  it 'should return the top specified number of items ranked by revenue' do
    items = create_list(:item, 4, name: 'Top Item')
    invoice = create(:invoice)
    create_list(:invoice_item, 5, quantity: 5, unit_price: 1000, item: items[0], invoice: invoice)
    create_list(:invoice_item, 5, quantity: 3, unit_price: 900, item: items[1], invoice: invoice)
    create_list(:invoice_item, 5, quantity: 2, unit_price: 600, item: items[2], invoice: invoice)
    create_list(:invoice_item, 5, quantity: 1, unit_price: 400, item: items[3], invoice: invoice)
    create(:transaction, invoice: invoice, result: 'success')

    get '/api/v1/items/most_revenue?quantity=2'

    expect(response).to have_http_status(200)

    items_returned = JSON.parse(response.body)

    expect(items_returned.size).to eq(2)
    expect(items_returned[0]['name']).to eq(items[0].name)
  end
end
