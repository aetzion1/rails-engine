class Item < ApplicationRecord
  belongs_to :merchant
  validates :merchant_id, presence: true

  scope :sorted, lambda{ order('id ASC') }

end