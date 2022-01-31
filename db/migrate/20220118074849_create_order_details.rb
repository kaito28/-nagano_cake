class CreateOrderDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :order_details do |t|
      
      t.integer  :order_id,    null: false, default: ""
      t.string   :item_id,     null: false, default: ""
      t.integer  :price,  null: false, default: ""
      t.integer  :amount,    null: false, default: ""
      t.integer  :maiking_status, null: false, default: 0
      # e num設定 ０= 着手不可、１= 製作待ち、２= 製作中、３= 製作完了 初期値は0(着手不可)
  
      t.timestamps
    end
  end
end
