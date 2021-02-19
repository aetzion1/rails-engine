class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    if Merchant.exists?(id: params[:id])
      @items = Item.where('merchant_id = ?', params[:id])
    else
      return render text: 'Merchant Not Found', status: :not_found
    end
    render json: ItemSerializer.new(@items.sorted)
  end
end
