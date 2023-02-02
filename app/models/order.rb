class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  enum payment_method: { credit_card: 0, transfer: 1 }



  def total_payment
    total = 0
    order_details.each do |order_detail|
     total = total + order_detail.price * order_detail.amount
    end
    return total
  end



end



