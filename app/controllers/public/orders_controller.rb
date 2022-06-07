class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order=Order.new
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items=current_customer.cart_items.all
    @total=0
    if params[:order][:select_address]=="0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:select_address]=="1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    end
  end

  def create
    @order=Order.new(order_params)
    @order.customer_id=current_customer.id
    if @order.save
      @cart_items=current_customer.cart_items.all
      @cart_items.each do |cart_item|
        order_detail=OrderDetail.new(item_id: cart_item.item.id, order_id: @order.id, price: cart_item.item.price, amount: cart_item.amount)
        order_detail.save
      end
      @cart_items.destroy_all
      redirect_to complete_orders_path
    else
      render :new
    end
  end

  def complete
  end

  def index
  end

  def show

  end




  private
    def order_params
      params.require(:order).permit(:payment, :postal_code, :address, :name, :postage, :total_price)
    end

end
