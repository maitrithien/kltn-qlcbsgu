class CreateCanBoThongTins < ActiveRecord::Migration
  def self.up
    create_table :can_bo_thong_tins do |t|
      t.string :ma_cb
      t.string :ho_ten
      t.string :ten_goi_khac
      t.boolean :gioi_tinh, :default=>true
      t.string :hinh_anh
      t.date :ngay_sinh
      t.string :noi_sinh
      t.string :que_quan
      t.string :dan_toc
      t.string :ton_giao
      t.string :so_cmnd
      t.date :ngay_cap_cmnd
      t.string :so_BHXH
      t.string :noi_dang_ky_ho_khau_thuong_tru
      t.string :noi_o_hien_nay
      t.string :tep_tin_dinh_kem
      t.boolean :is_deleted, :default=>false
      
      t.timestamps
    end
  end

  def self.down
    drop_table :can_bo_thong_tins
  end
end