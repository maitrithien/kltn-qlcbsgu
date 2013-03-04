class CreateCanBoLiLichCts < ActiveRecord::Migration
  def self.up
    create_table :can_bo_li_lich_cts do |t|
      t.references :can_bo_thong_tin
      t.date :ngay_vao_dang
      t.date :ngay_nhap_ngu
      t.date :ngay_xuat_ngu
      t.string :quan_ham_cao_nhat
      t.string :danh_hieu_duoc_phong_tang
      t.string :thuong_binh_hang
      t.string :con_gia_dinh_chinh_sach
      
      t.timestamps
    end
  end

  def self.down
    drop_table :can_bo_li_lich_cts
  end
end