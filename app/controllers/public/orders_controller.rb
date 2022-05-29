class Public::OrdersController < ApplicationController
  def new
    @order=Order.new
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.last_name + current_customer.first_name
  end

  def create
    @order=Order.new(order_params)
    @order.save
    redirect_to orders_confirm_path
  end

  def complete
  end

  def index
  end

  def show
  end


  private
    def order_params
      params.require(:order).permit(:payment, :postal_code, :address, :name)
    end
end
