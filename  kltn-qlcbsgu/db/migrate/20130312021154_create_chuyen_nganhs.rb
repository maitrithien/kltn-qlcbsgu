class CreateChuyenNganhs < ActiveRecord::Migration
  def self.up
    create_table :chuyen_nganhs do |t|
      t.string :ten_chuyen_nganh
      t.string :ghi_chu
      
      t.timestamps
    end
  end

  def self.down
    drop_table :chuyen_nganhs
  end
end