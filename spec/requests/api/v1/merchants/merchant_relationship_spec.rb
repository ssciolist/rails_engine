require 'rails_helper'

describe 'Merchants API item relation' do
  it 'loads a collection of items associated with one merchant' do
    merchant = create(:merchant)
    merchant.items.create(attributes_for(:item))
    merchant.items.create(attributes_for(:item))
    merchant.items.create(attributes_for(:item))

    get "/api/v1/merchants/#{merchant.id}/items"

    items = JSON.parse(response.body)

    expect(response).to be_success
    items.each { |i| expect(i['merchant_id']).to eq(merchant.id)}
  end
end
