class CreateChucVus < ActiveRecord::Migration
  def self.up
    create_table :chuc_vus do |t|
      t.string :ten_chuc_vu
      t.float :he_so_phu_cap
      t.string :ghi_chu
      
      t.timestamps
    end
  end

  def self.down
    drop_table :chuc_vus
  end
end