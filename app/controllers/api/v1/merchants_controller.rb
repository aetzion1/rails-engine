class Api::V1::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.limit(per_page).offset(page)
    render json: MerchantSerializer.new(@merchants)
  end

  def show
    @merchant = Merchant.find(params[:id])
    render json: MerchantSerializer.new(@merchant)
  end

  private

  def page
    return 0 if params[:page].nil?

    (params.fetch(:page).to_i - 1) * 20
  end

  def per_page
    [
      params.fetch(:per_page, 20).to_i,
      100
    ].min
  end
end
