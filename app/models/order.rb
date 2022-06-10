class Order < ApplicationRecord
  enum payment: {credit: 0, bank: 1}
  enum status: {stand_by: 0, confirmation: 1,
    production: 2, preparation: 3, completion: 4}

  has_many :order_details
  belongs_to :customer

  def total_amount
    sum=0
    order_details.each do |order_detail|
      sum+=order_detail.amount
    end
    return sum
  end

  def item_total_price
    sum=0
    order_details.each do |order_detail|
      sum+=order_detail.subtotal
    end
    return sum
  end
end
