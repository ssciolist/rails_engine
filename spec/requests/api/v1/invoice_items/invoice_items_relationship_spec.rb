require 'rails_helper'

describe 'Invoice Item API relations' do
  it '/item loads the associated item' do
    invoice_item = create(:invoice_item)


    get "/api/v1/invoice_items/#{invoice_item.id}/item"

    item = JSON.parse(response.body)

  end

  it '/invoice loads the associated invoice' do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

    invoice = JSON.parse(response.body)

  end
end
