class Api::V1::Merchants::CustomerController < ApplicationController
  def index

  end

  def show
    render json: Customer.favorite_customer(params[:id])
  end
end
