require 'rails_helper'

describe "Items API" do
  it 'should have a reachable path which sends an index of items' do
    create_list(:items, 1)

    get '/api/vi/items'
    expect(response).to be_sucessful
    items = JSON.parse(response.body)
    expect(items.count).to eq(3)
  end

  it 'should return a specific requested item' do
    item_id = create(:item).id

    get "api/vi/items/#{item_id}"

    item = JSON.parse(response.body)
    expect(item["id"]).to eq(item_id)
  end

end
