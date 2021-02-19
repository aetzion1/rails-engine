class Api::V1::Items::MerchantsController < ApplicationController
  def index
    if Item.exists?(id: params[:id])
      @merchant = Item.find(params[:id]).merchant
    else
      return render text: 'Merchant Not Found', status: :not_found
    end
    render json: MerchantSerializer.new(@merchant)
  end
end
