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

  it 'can find single object from given params' do
    create(:merchant, name: 'Willms and Sons')
    name = 'Hand-Spencer'
    create(:merchant, name: name)

    get "/api/v1/merchants/find?name=#{name}"
    expect(response).to be_success

    merchant = JSON.parse(response.body)

    expect(merchant['name']).to eq('Hand-Spencer')
  end
end
