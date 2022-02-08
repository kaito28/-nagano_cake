class Admin::HomesController < ApplicationController

  def top
  @orders = Order.where(customer_id:current_customer)
  params[:id] # 会員詳細から
  @orders = Order.page(params[:page]).per(10)
  end


end

