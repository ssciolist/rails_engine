class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    render json: Merchant.single_revenue.find(params[:id]).revenue
  end
end
