require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to have_http_status(200)

    merchants = JSON.parse(response.body)

    expect(merchants.length).to eq(3)
  end
end
