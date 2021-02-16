class Api::V1::ItemsController < ApplicationController
  def index
    if params[:merchant_id].nil?
      if params.fetch(:per_page, 20).to_i >= 250000
        @items = Item.all
      else
        @items = Item.limit(per_page).offset(page)
      end
    elsif Merchant.exists?(id: params[:merchant_id])
      @items = Item.where('merchant_id = ?', params[:merchant_id])
    else
      return render text: 'Merchant Not Found', status: :not_found
    end
    render json: ItemSerializer.new(@items.sorted)
  end

  def show
    @item = Item.find(params[:id])
    render json: ItemSerializer.new(@item)

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

  def page
    return 0 if params[:page].nil?

    (params.fetch(:page).to_i - 1) * 20
    # ADD SAD PATH TO ENSURE PAGE >= 1
    # ADD SAD PATH, PAGE HIGHER THAN MAX
  end

  def per_page
    [
      params.fetch(:per_page, 20).to_i,
      100
    ].min
  end
end
