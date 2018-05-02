require 'rails_helper'

describe 'Merchant API business intelligence' do
  skip 'returns specified number of merchants with the most items' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)
    merchant1.items.create!(attributes_for(:item))
    merchant1.items.create(attributes_for(:item))
    merchant1.items.create(attributes_for(:item))
    merchant2.items.create(attributes_for(:item))
    merchant2.items.create(attributes_for(:item))
    merchant3.items.create(attributes_for(:item))

    get '/api/v1/merchants/most_items?quantity=2'

    top_merchants = JSON.parse(response.body)

    expect(response).to be_success
    expect(top_merchants.count).to eq(2)
    expect(top_merchants.first.name).to eq(merchant1.name)
    expect(top_merchants.last.name).to eq(merchant2.name)
    expect(top_merchants).to_not have_content(merchant3.name)
  end
end
