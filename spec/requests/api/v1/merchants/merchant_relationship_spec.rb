require 'rails_helper'

describe 'Merchants API relations' do
  it '\items loads a collection of items associated with one merchant' do
    merchant = create(:merchant)
    merchant.items.create(attributes_for(:item))
    merchant.items.create(attributes_for(:item))
    merchant.items.create(attributes_for(:item))

    get "/api/v1/merchants/#{merchant.id}/items"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(3)
    items.each { |item| expect(item['merchant_id']).to eq(merchant.id)}
  end

  it '\invoices loads a collection of invoices associated with one merchant' do
    merchant = create(:merchant)
    merchant.invoices.create(attributes_for(:invoice))
    merchant.invoices.create(attributes_for(:invoice))
    merchant.invoices.create(attributes_for(:invoice))

    get "/api/v1/merchants/#{merchant.id}/invoices"

    invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoices.count).to eq(3)
    invoices.each { |invoice| expect(invoice['merchant_id'].to eq(merchant.id)) }
  end
end
