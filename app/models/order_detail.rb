class OrderDetail < ApplicationRecord
  enum status: {not_startable: 0, stand_by: 1,
    production: 2, completion: 3}

  belongs_to :order
  belongs_to :item

  def subtotal
    item.with_tax_price * amount
  end
end
