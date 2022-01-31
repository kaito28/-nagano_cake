class Admin::OrdersController < ApplicationController

   before_action :authenticate_admin!

  def index
    if params[:id] # 会員詳細から
      @orders = Customer.find(params[:id]).orders.page(params[:page]).per(10)

    elsif request.fullpath.include? "today" 
      @orders = Order.where(created_at:  Time.zone.now.all_day).page(params[:page]).per(10)

    elsif request.fullpath.include? "yesterday" # TOP本日製作分から
      @orders = Order.where(created_at: 1.day.ago.all_day).page(params[:page]).per(10)

    else
      @orders = Order.page(params[:page]).per(10)
    end
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
    @items_total_payment = calculate(@order)
  end

  def calculate(items_total_price) # 商品合計を算出するメソッド
    @items_total_payment= 0
    @order_details.each {|order_detail|
    tax_in_price = (order_detail.item_price * 1.1).floor
    sub_total_payment = tax_in_price * order_detail.amount
    @items_total_payment += sub_total_payment
    }
    return @items_total_payment
  end

  def order_status_update
    order = Order.find(params[:id])
    order.update(order_params)
    # OrderModel after_update => 製作ステータスの自動変更
    redirect_to admin_order_path(order)
  end

  def item_status_update
    order_detail = OrderDetail.find(params[:id])
    order_detail.update(order_detail_params)
    # OrderDetailModel after_update => 注文ステータスの自動更新
    redirect_to admin_order_path(order_detail.order_id)
  end

  private
  def order_params
    params.require(:order).permit(:status)
  end

  def order_detail_params
    params.require(:order_detail).permit(:is_active)
  end

end
