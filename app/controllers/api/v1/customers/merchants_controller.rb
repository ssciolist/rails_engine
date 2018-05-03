class Api::V1::Customers::MerchantsController < ApplicationController
  def show
    render json: Merchant.favorite_merchant(params[:id])
  end
end
