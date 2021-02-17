class Api::V1::Items::MerchantsController < ApplicationController
  def show
    if Item.exists?(id: params[:item_id])
      @merchant = Item.find(params[:item_id]).merchant
    else
      return render text: 'Merchant Not Found', status: :not_found
    end
    render json: MerchantSerializer.new(@merchant)
  end
end
