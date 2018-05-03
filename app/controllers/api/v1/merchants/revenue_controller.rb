class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: Merchant.revenue_by_date(params[:date])
  end

  def show
    if params[:date]
      render json: Merchant.single_revenue_by_date(params[:date]).find(params[:id]).revenue, serializer: MerchantRevenueSerializer
    else
      render json: Merchant.single_revenue.find(params[:id]).revenue, serializer: MerchantRevenueSerializer
    end
  end
end
