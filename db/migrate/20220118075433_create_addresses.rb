class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      
      t.integer :customer_id,   null: false, default: ""
      t.string  :name,     null: false, default: ""
      t.string  :postal_code,     null: false, default: ""
      t.text    :address,       null: false, default: ""

      
      

      t.timestamps
    end
  end
end
