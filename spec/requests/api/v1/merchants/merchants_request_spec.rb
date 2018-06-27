require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to have_http_status(200)

    merchants = JSON.parse(response.body)

    expect(merchants.length).to eq(3)
  end

  it 'can get one merchant by its id' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(merchant['id']).to eq(id)
  end

  it 'can find single merchant from given params' do
    merchant = create(:merchant, updated_at: "2012-03-27T14:56:04.000Z")
    create_list(:merchant, 4)

    get "/api/v1/merchants/find?updated_at=2012-03-27T14:56:04.000Z"
    expect(response).to have_http_status(200)

    merchant_returned = JSON.parse(response.body)

    expect(merchant_returned['id']).to eq(merchant.id)
  end

  it 'can find all merchants from given params' do
    create_list(:merchant, 3, name: 'Kozey Group')
    name = 'Tillman Group'
    create_list(:merchant, 5, name: name)

    get "/api/v1/merchants/find_all?name=#{name}"
    expect(response).to have_http_status(200)

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(5)
    merchants.each do |merchant|
      expect(merchant['name']).to eq(name)
    end
  end

  it 'can return a random merchant' do
    merchants = create_list(:merchant, 8)

    get '/api/v1/merchants/random'
    expect(response).to have_http_status(200)

    merchant = JSON.parse(response.body)

    expect(merchant[0]['name']).to eq(merchants[1].name)
  end
end
