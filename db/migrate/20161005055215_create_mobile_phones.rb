class CreateMobilePhones < ActiveRecord::Migration[5.0]
  def change
    create_table :mobile_phones do |t|
      t.string : phone_number, null:false
      t.string : flg1, default:0
      t.string : flg2, default:0
      t.timestamps
    end
  end
end
