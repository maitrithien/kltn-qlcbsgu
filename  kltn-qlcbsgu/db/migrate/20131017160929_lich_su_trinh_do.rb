class LichSuTrinhDo < ActiveRecord::Migration
  def up
  	create_table :lich_su_trinh_dos do |t|
      t.integer :can_bo_thong_tin_id
      t.integer :trinh_do_chuyen_mon_id
      t.integer :chuyen_nganh_id
      t.date :thoi_gian_dat_duoc
      t.text :ghi_chu
      
      t.timestamps
    end
  end

  def down
  	drop_table :lich_su_trinh_dos
  end
end
