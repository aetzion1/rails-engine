class Invoice < ApplicationRecord
  belongs_to :merchant, dependent: :destroy
  belongs_to :item, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :transactions, dependent: :destroy

  enum status: [:unshipped, :shipped]
end