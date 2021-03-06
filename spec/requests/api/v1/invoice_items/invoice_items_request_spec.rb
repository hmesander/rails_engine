require 'rails_helper'

describe 'Invoice Items API' do
  it 'should return an index of invoice_items' do
    create_list(:invoice_item, 5)

    get '/api/v1/invoice_items'

    expect(response).to have_http_status(200)

    invoice_items = JSON.parse(response.body)

    expect(invoice_items.count).to eq(5)
  end

  it 'should return a specific invoice_item by id' do
    invoice_item_id = create(:invoice_item).id

    get "/api/v1/invoice_items/#{invoice_item_id}"

    expect(response).to have_http_status(200)

    invoice_item = JSON.parse(response.body)

    expect(invoice_item['id']).to eq(invoice_item_id)
  end

  it 'should find an invoice_item with arbitrary params' do
    invoice_item = create(:invoice_item)
    create_list(:invoice_item, 4)

    get "/api/v1/invoice_items/find?quantity=#{invoice_item.quantity}"

    expect(response).to have_http_status(200)

    returned_invoice_item = JSON.parse(response.body)

    expect(returned_invoice_item['quantity']).to eq(invoice_item.quantity)
    expect(returned_invoice_item['id']).to eq(invoice_item.id)
  end

  it 'should return all invoice_items with certain params' do
    unit_price = 100_023
    create_list(:invoice_item, 10, unit_price: unit_price)
    create_list(:invoice_item, 3, unit_price: 12_345)

    get "/api/v1/invoice_items/find_all?unit_price=#{unit_price}"

    expect(response).to have_http_status(200)

    returned_invoice_items = JSON.parse(response.body)

    expect(returned_invoice_items.count).to eq(10)
  end

  it 'should return a random invoice_item' do
    create_list(:invoice_item, 10)
    possible_ids = InvoiceItem.all.map(&:id)

    get '/api/v1/invoice_items/random'

    expect(response).to have_http_status(200)

    invoice_item = JSON.parse(response.body)

    expect(possible_ids).to include(invoice_item[0]['id'])
  end
end
