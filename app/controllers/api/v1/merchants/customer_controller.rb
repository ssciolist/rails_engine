class Api::V1::Merchants::CustomerController < ApplicationController
  def index
    render json: Merchant.find(params[:id]).customer_pending_invoices
  end

  def show
    render json: Customer.favorite_customer(params[:id])
  end
end
