class CreateQuaTrinhCongTacs < ActiveRecord::Migration
  def self.up
    create_table :qua_trinh_cong_tacs do |t|
      t.references :can_bo_thong_tin
      t.references :don_vi
      t.references :chuc_vu
      t.date :thoi_gian_bat_dau
      t.date :thoi_gian_ket_thuc
      
      t.timestamps
    end
  end

  def self.down
    drop_table :qua_trinh_cong_tacs
  end
end