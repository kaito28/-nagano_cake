class OrdersController < ApplicationController


  def index
    @orders = Order.where(customer_id:current_customer)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def new
    @addresses = current_customer.addresses
    @address = Address.new
    @order = Order.new
  end

  #情報入力画面でボタンを押して情報をsessionに保存
  def create
    session[:payment] = params[:payment]
    if params[:select] == "select_address"
      session[:address] = params[:address]
    elsif params[:select] == "my_address"
      session[:address] = "〒" + current_customer.postal_code + current_customer.address + current_customer.lname
    end
    if session[:address].present? && session[:payment].present?
      redirect_to orders_confirm_path
    else
      flash[:order_new] = "支払い方法と配送先を選択して下さい"
      redirect_to new_order_path
    end




  end
  # 購入確認画面
  def confirm
      @orders = current_customer.orders
      @total_payment = calculate(current_customer)

      if  session[:address]
        @address = Address.find(session[:address])
      end
  end

  # 情報入力画面にて新規配送先の登録
  def create_address
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @address.save
    redirect_to new_order_path
  end


  def create_order
    # オーダーの保存
    @order = Order.new
    @order.customer_id = current_customer.id
    @order.address = session[:address]
    @order.payment_method = session[:payment]
    @order.total_payment = calculate(current_customer)
    @order.status = 0
    @order.save
    # saveができた段階でOrderモデルにorder_idが入る

    # オーダー商品ごとの詳細の保存
    current_customer.cart_items.each do |cart|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_name = cart.item.name
      @order_detail.item_price = cart.item.price
      @order_detail.amount = cart.amount
      @order_detail.is_active = 0
      @order_detail.save

    end
    current_customer.cart_items.destroy_all
    session.delete(:address)
    session.delete(:payment_method)
    redirect_to thanks_path
  end

  private
   def address_params
     params.require(:address).permit(:customer_id,:name, :postal_code, :address)
   end
   def order_params
     params.require(:order).permit(:customer_id, :address, :payment_method, :shipping_cost, :total_payment, :status)
   end

   # 商品合計（税込）の計算
   def calculate(user)
     total_amount = 0
     user.cart_items.each do |cart_item|
     total_amount = cart_item.amount + cart_item.item.price
     end
     return (total_amount * 1.1).floor
   end

end
