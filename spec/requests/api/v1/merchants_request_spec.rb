require 'rails_helper'

describe 'Merchants API index' do
  it 'sends a list of all merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_success

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(3)
  end

  it 'can show one merchant by its id' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant['id']).to eq(id)
  end

  it 'can find me a merchant by name' do
    merchant = create(:merchant, name: 'Pierre', created_at: Date.new(2001,2,3), updated_at: Date.new(2011,2,3))

    get "/api/v1/merchants/find?name=Pierre"

    search_result = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant['name']).to eq(search_result[:name])
    expect(merchant['created_at']).to eq(search_result[:created_at])
    expect(merchant['updated_at']).to eq(search_result[:updated_at])
  end
end
