class Api::V1::ItemsController < ApplicationController
  def index
    if params[:merchant_id].nil?
      @items = Item.all
    elsif Merchant.exists?(id: params[:merchant_id])
      @items = Item.where('merchant_id = ?', params[:merchant_id])
    else
      return render text: 'Merchant Not Found', status: :not_found
    end
    render json: ItemSerializer.new(@items.sorted)
  end

  def show
    @item = Item.find(params[:id])
    ItemSerializer.new(@item)

    # options[:include] = [:stores, :'stores.name']
    # serializable_hash = BookSerializer.new([@book], options).serializable_hash
    # require 'pry'; binding.pry
  end

  def create
    render json: Item.create(item_params)
  end

  def update
    render json: Item.update(params[:id], item_params)
  end

  def destroy
    render json: Item.delete(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(
      :name,
      :description,
      :unit_price,
      :merchant
    )
  end
end
