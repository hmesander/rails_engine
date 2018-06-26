require 'rails_helper'

describe "Items API" do
  it 'should have a reachable path which sends an index of items' do
    create(:item)

    get '/api/v1/items'
    expect(response).to be_successful
    items = JSON.parse(response.body)
    expect(items.count).to eq(1)
  end

  it 'should return a specific requested item' do
    item_id = create(:item).id

    get "/api/v1/items/#{item_id}"

    item = JSON.parse(response.body)
    expect(item["id"]).to eq(item_id)
  end

end
