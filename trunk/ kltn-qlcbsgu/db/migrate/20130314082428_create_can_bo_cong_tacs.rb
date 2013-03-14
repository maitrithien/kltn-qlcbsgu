class CreateCanBoCongTacs < ActiveRecord::Migration
  def self.up
    create_table :can_bo_cong_tacs do |t|
      t.references :can_bo_thong_tin
      t.references :don_vi
      t.string :nghe_nghiep_truoc_tuyen_dung
      t.string :cong_viec_chinh_duoc_giao
      t.string :so_truong_cong_tac
      t.date :ngay_bat_dau_lam_viec
      t.string :ghi_chu
      
      t.timestamps
    end
  end

  def self.down
    drop_table :can_bo_cong_tacs
  end
end