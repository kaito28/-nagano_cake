class Order < ApplicationRecord

  belongs_to :customer
	has_many   :order_details, dependent: :destroy
	enum status: [ :入金確認, :製作中,  :発送済み]
	enum payment_method: [:クレジットカード, :銀行振込]
  accepts_nested_attributes_for :order_details

end

