class Invoice < ApplicationRecord
  belongs_to :merchant, dependent: :destroy
  belongs_to :customer, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :items, through: :invoice_items

  validates :customer_id, presence: true
	validates :merchant_id, presence: true
	validates :status, presence: true

  enum status: [:unshipped, :shipped]

  scope :date_between, -> (start_date, end_date) {
		where("invoices.updated_at >= ? AND invoices.updated_at <= ?", Date.parse(start_date), Date.parse(end_date).end_of_day)
  }
end
