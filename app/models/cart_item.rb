class CartItem < ApplicationRecord


  validates :amount, presence: true

   belongs_to :customer
   belongs_to :item


end
