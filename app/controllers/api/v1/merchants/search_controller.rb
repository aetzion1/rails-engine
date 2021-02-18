class Api::V1::Merchants::SearchController < ApplicationController
  def show
    # return nil if merchant_params[:name].blank?
    @merchant = if merchant_params[:name].blank?
                  nil
                else
                  Merchant.where('LOWER(name) LIKE ?', "%#{merchant_params[:name].downcase}%").first
                end
    # ternary operator
    render json: (@merchant ? MerchantSerializer.new(@merchant) : { data: {} })
  end

  private

  def merchant_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
end
