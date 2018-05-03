require 'rails_helper'

describe 'Customer API business intelligence' do
  it 'returns customer favorite merchant' do
    customer = create(:customer)

    merchant = create(:merchant)
    item = merchant.items.create!(attributes_for(:item))
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice.transactions.create!(attributes_for(:transaction))
    invoice2 = create(:invoice, customer: customer, merchant: merchant)
    invoice2.transactions.create!(attributes_for(:transaction))

    merchant2 = create(:merchant)
    item2 = merchant2.items.create!(attributes_for(:item))
    invoice3 = create(:invoice, customer: customer, merchant: merchant2)
    invoice3.transactions.create!(attributes_for(:transaction))

    get "/api/v1/customers/#{customer.id}/favorite_merchant"

    favorite_merchant = JSON.parse(response.body)

    expect(response).to be_success

    expect(favorite_merchant['id']).to eq(merchant.id)
  end
end
