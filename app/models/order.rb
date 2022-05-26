class Order < ApplicationRecord
  enum payment: {credit: 0, bank: 1}
  enum status: {stand_by: 0, confirmation: 1,
    production: 2, preparation: 3, completion: 4}

  has_many :order_details
  belongs_to :customer
end
