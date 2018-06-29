require 'rails_helper'

describe 'Items API' do
  it 'should have a reachable path which sends an index of items' do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to have_http_status(200)

    items = JSON.parse(response.body)

    expect(items.count).to eq(3)
  end

  it 'should return a specific requested item by id' do
    item_id = create(:item).id

    get "/api/v1/items/#{item_id}"

    expect(response).to have_http_status(200)

    item = JSON.parse(response.body)

    expect(item['id']).to eq(item_id)
  end

  it 'should return a specific item using find' do
    item = create(:item)

    get "/api/v1/items/find?name=#{item.name}"

    expect(response).to have_http_status(200)

    returned_item = JSON.parse(response.body)

    expect(returned_item['name']).to eq(item.name)
    expect(returned_item['id']).to eq(item.id)
  end

  it 'should return all items matching a given parameter' do
    price = 2000
    create_list(:item, 10, unit_price: price)
    create_list(:item, 3, unit_price: 10)

    get "/api/v1/items/find_all?unit_price=#{price}"

    expect(response).to have_http_status(200)

    returned_items = JSON.parse(response.body)

    expect(returned_items.count).to eq(10)
  end

  it 'should return a random item' do
    create_list(:item, 10)
    possible_ids = Item.all.map(&:id)

    get '/api/v1/items/random'

    expect(response).to have_http_status(200)

    item = JSON.parse(response.body)

    expect(possible_ids).to include(item[0]['id'])
  end
end
