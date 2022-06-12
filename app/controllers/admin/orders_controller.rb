class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order=Order.find(params[:id])
    @total=0
  end

  def update
    @order=Order.find(params[:id])
    @order.update(order_params)
    if @order.status=="confirmation"
      OrderDetail.where(order_id: @order.id).update_all(status: "stand_by")
    end
    redirect_to admin_order_path(@order.id)
  end


  private
    def order_params
      params.require(:order).permit(:status)
    end

end
