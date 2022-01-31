class OrderDetail < ApplicationRecord
  
  	belongs_to :order
	  enum is: [:着手不可, :製作待ち, :製作中, :製作完了]


end
