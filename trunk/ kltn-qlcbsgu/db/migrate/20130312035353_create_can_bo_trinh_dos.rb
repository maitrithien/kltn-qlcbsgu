class CreateCanBoTrinhDos < ActiveRecord::Migration
  def self.up
    create_table :can_bo_trinh_dos do |t|
      t.string :trinh_do_gd_pho_thong
      t.references :can_bo_thong_tin
      t.references :trinh_do_chuyen_mon
      t.references :chuyen_nganh
      t.references :ly_luan_chinh_tri
      t.references :quan_ly_nha_nuoc
      t.references :ngoai_ngu
      t.references :hoc_ham
      t.references :hoc_vi
      t.string :trinh_do_ngoai_ngu
      t.string :trinh_do_tin_hoc
      
      t.timestamps
    end
  end

  def self.down
    drop_table :can_bo_trinh_dos
  end
end