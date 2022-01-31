class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|


      t.integer  :customer_id,    null: false, default: ""
      t.string   :postal_code,    null: false, default: ""
      t.text     :address,        null: false, default: ""
      t.string   :name,           null: false, default: ""
      t.integer  :shipping_cost,  null: false, default: ""
      t.integer  :total_payment,  null: false
      t.integer  :payment_method, null: false, default: ""
      t.integer  :status,         null: false, default: "0"

      # e_num設定 ０= 入金待ち、１= 入金確認、２= 製作中、３= 発送準備中、４= 発送済み 登録時は0(入金待ち)

      t.timestamps
    end
  end
end
