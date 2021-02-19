class ItemsSoldSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name
  attribute :count do |object|
        object.count = object.count.to_i
      end
end
