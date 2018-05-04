class Api::V1::Customers::SearchController < ApplicationController
  def show
    render json: Customer.find_by(search_params)
  end

  def index
    render json: Customer.where(search_params)
  end

  private

  def search_params
    search = { params.keys.first.to_sym => params.values.first }
    if search.keys.first == :unit_price
      search[:unit_price] = search[:unit_price].delete('.').to_i
    end
    search
  end
end
