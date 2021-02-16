class Item < ApplicationRecord
  belongs_to :merchant, dependent: :destroy
  validates :merchant_id, presence: true

  scope :sorted, -> { order('id ASC') }
end
