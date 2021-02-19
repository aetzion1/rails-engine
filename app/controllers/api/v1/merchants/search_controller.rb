class Api::V1::Merchants::SearchController < ApplicationController
  def find_one
    # return nil if merchant_params[:name].blank?
    merchant = if merchant_params[:name].blank?
                  nil
                else
                  Merchant.where('LOWER(name) LIKE ?', "%#{merchant_params[:name].downcase}%").first
                  # Try this: negates need for LOWER or downcase. Also helps manage weird characters.
                  # Merchant.where("#{merchant_params[:name]} ilike '%#{merchant_params[:nameto_sym]}'").first
                end
    response = MerchantSerializer.new(merchant)
    render json: (merchant ? response : { data: {} })
  end

  private

  def merchant_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
end
