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

  it 'can find a merchant by name' do
    merchant = create(:merchant, name: 'Pierre', created_at: Date.new(2001,2,3), updated_at: Date.new(2011,2,3))

    get "/api/v1/merchants/find?name=Pierre"

    search_result = JSON.parse(response.body)

    expect(response).to be_success
    expect(search_result['name']).to eq(merchant[:name])
    expect(search_result['id']).to eq(merchant[:id])
  end

  it 'can find a merchant by id' do
    merchant = create(:merchant, name: 'Joja Mart', created_at: Date.new(2002,2,3), updated_at: Date.new(2012,2,3))

    get "/api/v1/merchants/find?id=#{merchant.id}"

    search_result = JSON.parse(response.body)

    expect(response).to be_success
    expect(search_result['name']).to eq(merchant[:name])
    expect(search_result['id']).to eq(merchant[:id])
  end

  it 'can find a merchant by created_at' do
    merchant = create(:merchant, name: 'Mouse', created_at: Date.new(2003,2,3), updated_at: Date.new(2013,2,3))

    get "/api/v1/merchants/find?created_at=#{merchant.created_at}"

    search_result = JSON.parse(response.body)

    expect(response).to be_success
    expect(search_result['name']).to eq(merchant[:name])
    expect(search_result['id']).to eq(merchant[:id])
  end

  it 'can find a merchant by created_at' do
    merchant = create(:merchant, name: 'Mouse', created_at: Date.new(2003,2,3), updated_at: Date.new(2013,2,3))

    get "/api/v1/merchants/find?created_at=#{merchant.created_at}"

    search_result = JSON.parse(response.body)

    expect(response).to be_success
    expect(search_result['name']).to eq(merchant[:name])
    expect(search_result['id']).to eq(merchant[:id])
  end

  it 'can find a merchant by updated_at' do
    merchant = create(:merchant, name: 'Mouse', created_at: Date.new(2004,2,3), updated_at: Date.new(2014,2,3))

    get "/api/v1/merchants/find?updated_at=#{merchant.updated_at}"

    search_result = JSON.parse(response.body)

    expect(response).to be_success
    expect(search_result['name']).to eq(merchant[:name])
    expect(search_result['id']).to eq(merchant[:id])
  end
end
