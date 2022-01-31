class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|

      t.integer  :genre_id,    index: true, null: false, default: ""
      t.string   :name,        null: false, default: ""
      t.string   :image_id
      t.text     :introduction
      t.integer  :price,       null: false, default: ""
      t.integer  :is_active, null: false, default: 1
      # e_num設定 ０ = 販売可、１ = 販売不可　登録時は販売不可


      t.timestamps
    end
  end
end
