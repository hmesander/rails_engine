require 'rails_helper'
describe "Top Items by revenue" do
  it 'should return the top specified number of items ranked by revenue' do
    item1 = create(:item, name:"Top Item")
    item2 = create(:item, name:"Top Item")
    item3 = create(:item, name:"Top Item")
    item4 = create(:item, name:"Top Item")

    invoice = create(:invoice)

    create_list(:invoice_item, 5, quantity: 5, unit_price: 1000, item: item1, invoice: invoice) 
    create_list(:invoice_item, 5, quantity: 3, unit_price: 900, item: item2, invoice: invoice) 
    create_list(:invoice_item, 5, quantity: 2, unit_price: 600, item: item3, invoice: invoice) 
    create_list(:invoice_item, 5, quantity: 1, unit_price: 400, item: item4, invoice: invoice) 

    create(:transaction, invoice: invoice, result: "success")

    get '/api/v1/items/most_revenue?quantity=2'

    items_returned = JSON.parse(response.body)

    expect(items_returned.size).to eq(2)
    expect(items_returned[0]["name"]).to eq(item1.name)
  end
end
