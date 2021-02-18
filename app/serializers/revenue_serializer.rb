class RevenueSerializer
  include FastJsonapi::ObjectSerializer
  set_type :merchant_name_revenue
  attributes :name
  attribute :revenue do |object|
        object.revenue = (object.revenue.to_f).to_f
      end
end
