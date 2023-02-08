class Admin::HomesController < ApplicationController
  def top
    @orders = Order.all.page(params[:page])

  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end
end
