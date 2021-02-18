class Transaction < ApplicationRecord
  belongs_to :invoice, dependent: :destroy

  enum result: [:failed, :success]
end