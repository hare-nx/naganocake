class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail=OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    order=Order.find(params[:order_id])
    if @order_detail.status=="production"
      order.update(status: "production")
    elsif OrderDetail.where(order_id: order.id).pluck(:status).all?("completion")
      order.update(status: "preparation")
    end
    redirect_to admin_order_path(order.id)
  end


  private
    def order_detail_params
      params.require(:order_detail).permit(:status)
    end
end
