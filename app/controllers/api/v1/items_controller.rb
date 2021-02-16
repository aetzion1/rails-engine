class Api::V1::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    if params[:merchant_id].nil?
      @items = Item.all
    else
      if @merchant.nil?
        return render :text => "Merchant Not Found", :status => 404
      else
        @items = Item.where('merchant_id = ?', params[:merchant_id])
      end
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

  # def create
  #   render json: Book.create(book_params)
  # end

  # def update
  #   render json: Book.update(params[:id], book_params)
  # end

  # def destroy
  #   render json: Book.delete(params[:id])
  # end

  private
    def item_params
      params.require(:item).permit(
                                    :name,
                                    :description,
                                    :unit_price
                                  )
    end
end
