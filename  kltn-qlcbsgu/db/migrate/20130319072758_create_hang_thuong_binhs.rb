class CreateHangThuongBinhs < ActiveRecord::Migration
  def self.up
    create_table :hang_thuong_binhs do |t|
      t.string :ti_le_thuong_tat
      t.string :ghi_chu
      
      t.timestamps
    end
  end

  def self.down
    drop_table :hang_thuong_binhs
  end
end