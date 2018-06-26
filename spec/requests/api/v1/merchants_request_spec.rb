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
    create(:merchant, name: 'Willms and Sons')
    name = 'Hand-Spencer'
    create(:merchant, name: name)

    get "/api/v1/merchants/find?name=#{name}"
    expect(response).to have_http_status(200)

    merchant = JSON.parse(response.body)

    expect(merchant['name']).to eq('Hand-Spencer')
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
    create_list(:merchant, 8)

    get '/api/v1/merchants/random'
    expect(response).to have_http_status(200)

    merchant = JSON.parse(response.body)

    expect(merchant.count).to eq(1)
    expect(merchant.keys).to eq(['id', 'name'])
  end
end
