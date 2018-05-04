require 'rails_helper'

describe 'Item API relations' do
  it '/item loads the associated invoice_items' do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice.invoice_items.create!(attributes_for(:invoice_item, item_id: item.id))
    invoice.invoice_items.create!(attributes_for(:invoice_item, item_id: item.id))
    invoice.invoice_items.create!(attributes_for(:invoice_item, item_id: item.id))


    get "/api/v1/items/#{item.id}/invoice_items"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items.count).to eq(3)
    invoice_items.each { |ii| expect(ii['item_id']).to eq(item.id)}

  end

  it '/item loads the associated merchant' do
    merchant1 = create(:merchant)
    item = Item.create(attributes_for(:item, merchant_id: merchant1.id))

    get "/api/v1/items/#{item.id}/merchant"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant['id']).to eq(merchant1.id)

  end
end
