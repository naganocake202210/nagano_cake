class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @total = 0
    @order.postage = 800
    @cart_items = current_customer.cart_items
    if params[:order][:select_address] == "0"
     @order.postal_code = current_customer.postal_code
     @order.address = current_customer.address
     @order.name = current_customer.last_name + current_customer.first_name
    end

  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.postage = 800
    @order.total_price = 0
    @order.order_status = 0
    @order.save
    cart_items = CartItem.where(customer_id: current_customer.id)
    cart_items.each do |cart_item|
      order_detail = OrderDetail.new
      order_detail.item_id = cart_item.item_id
      order_detail.order_id = @order.id
      order_detail.price = cart_item.item.with_tax_price
      order_detail.amount = cart_item.amount
      order_detail.manufacture_status = 0
      order_detail.save
      CartItem.destroy_all
    end
    redirect_to complete_path
  end

  def index
    @orders = Order.all

  end

  def show
    @order = Order.find(params[:id])
    

  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end
end
