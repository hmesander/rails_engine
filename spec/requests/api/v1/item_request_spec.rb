require 'rails_helper'

describe "Items API" do
  it 'should have a reachable path which sends an index of items' do
    create_list(:item, 3)

    get '/api/v1/items'
    expect(response).to be_successful
    items = JSON.parse(response.body)
    expect(items.count).to eq(3)
  end

  it 'should return a specific requested item by id' do
    item_id = create(:item).id

    get "/api/v1/items/#{item_id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["id"]).to eq(item_id)
  end

  it 'should return a specific item using find' do
    item =  create(:item)
    get "/api/v1/items/find?name=#{item.name}"

    returned_item = JSON.parse(response.body)
    
    expect(response).to be_successful
    expect(returned_item["name"]).tto eq(item.name)
    expect(returned_item["id"]).tto eq(item.id)
  end

  it 'should return all items matching a given parameter' do
    price = 2000
    create_list(:item, 10, unit_price: price)
    create_list(:item, 3, unit_price: 10)

    get "/api/v1/merchants/find_all?unit_price=#{price}"
    returned_items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(returned_items.count).to eq(10)
  end
  it 'should return a random item' do
    create_list(:item, 10)
    possible_ids = Item.all.map{|item| item.id}

    get '/api/v1/items/random'
    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(possible_ids).to include(item.id)
  end
end
