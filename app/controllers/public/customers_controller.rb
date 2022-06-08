class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show
    @customer=current_customer

  end


  def unsubscribe
  end

  def withdraw
    @customer=Customer.find_by(email: current_customer.email)
    @customer.update(is_active: false)
    reset_session
    redirect_to root_path
  end
end
