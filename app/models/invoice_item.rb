class InvoiceItem < ApplicationRecord
  belongs_to :item, dependent: :destroy
  belongs_to :invoice, dependent: :destroy

  validates :unit_price, presence: true
	validates :quantity, presence: true
end