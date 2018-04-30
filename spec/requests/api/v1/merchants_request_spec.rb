require 'rails_helper'

describe 'Merchants API index' do
  it 'sends a list of all merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_success
  end
end