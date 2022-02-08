class CustomersController < ApplicationController


       before_action :ensure_correct_customer, {only: [:show, :edit]}


  def show
  	@customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer)
    else
      render 'edit'
    end
  end

    def withdraw #退会画面を表示する
       @customer = current_customer
    end

    def switch
       @customer = Customer.find(params[:id])
       sign_out current_customer
       redirect_to root_path
    end



  private
  def customer_params
  	  params.require(:customer).permit(:is_active, :last_name, :first_name, :last_name_kana, :first_name_kana,
  	                                   :telephone_number, :email, :password, :postal_code, :address)
  end

  def ensure_correct_customer
    @customer = Customer.find(params[:id])
    if current_customer.id != @customer.id
       redirect_to root_path
    end
  end


end
