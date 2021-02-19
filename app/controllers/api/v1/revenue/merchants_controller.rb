class Api::V1::Revenue::MerchantsController < ApplicationController
  def index
    return render json: { error: 'Specify a quantity' }, status: '400' unless params[:quantity]

    @merchants = Merchant.most_revenue(revenue_params[:quantity])
    render json: MerchantNameRevenueSerializer.new(@merchants)
  end

  def show
    unless Merchant.find(merchant_params[:id].to_i)
      return render json: { error: 'Merchant doesnt exist' },
                    status: '400'
    end

    @revenue = Merchant.merchant_revenue(merchant_params[:id].to_i)
    # @revenue = @merchant.invoice_items.revenue
    render json: MerchantRevenueSerializer.get_revenue(@revenue, merchant_params[:id])
  end

  private

  def revenue_params
    params.permit(:quantity)
  end

  def merchant_params
    params.permit(:id)
  end
end
