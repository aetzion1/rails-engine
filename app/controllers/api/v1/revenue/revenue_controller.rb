class Api::V1::Revenue::RevenueController < ApplicationController

  def between_dates
    unless params[:start].present? && params[:end].present?
      return render json: { error: 'Specify dates' },
                    status: '400'
    end

    # params[:start].present?
    # return render json: { error: 'Specify dates' }, status: '400' unless params[:start_date].to_datetime < params[:start_date].to_datetime

    @revenue = Merchant.revenue_by_date(params[:start], params[:end])
    render json: RevenueSerializer.get_revenue(@revenue)
  end
  
  def merchants
    return render json: { error: 'Specify a quantity' }, status: '400' unless params[:quantity]

    @merchants = Merchant.most_revenue(revenue_params[:quantity])
    render json: MerchantNameRevenueSerializer.new(@merchants)
  end

  def merchant
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