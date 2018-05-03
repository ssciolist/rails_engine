class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: Merchant.revenue_by_date(params[:date])
  end

  def show
    render json: Merchant.single_revenue.find(params[:id]).revenue
  end
end
