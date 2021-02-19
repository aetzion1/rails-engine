class RevenueSerializer
  # include FastJsonapi::ObjectSerializer
  # id :nil
  # attribute :revenue do |object|
  #       object.revenue = (object.revenue.to_f).to_f
  #     end
  def self.get_revenue(revenue)
    { data: { id: nil, type: 'revenue', attributes: { revenue: revenue } } }
	end
end
