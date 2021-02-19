class Api::V1::RevenueController < ApplicationController

  def index
    return render json: { error: 'Specify dates' }, status: '400' unless params[:start_date] & params[:start_date] 
    # return render json: { error: 'Specify dates' }, status: '400' unless params[:start_date].to_datetime < params[:start_date].to_datetime 

    @revenue = Merchant.revenue_by_date(params[:start], params[:end])
    render json: RevenueSerializer.get_revenue(@revenue)
  end

end
