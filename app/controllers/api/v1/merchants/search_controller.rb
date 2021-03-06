class Api::V1::Merchants::SearchController < ApplicationController
  def show
    if merchant_params.keys.first == 'name'
      render json: Merchant.where('lower(name) = ?', merchant_params.values.first.downcase).first
    else
      render json: Merchant.find_by(merchant_params)
    end
  end

  def index
    render json: Merchant.where(merchant_params)
  end

  private

  def merchant_params
    params.permit(:name, :id, :created_at, :updated_at)
  end
end
