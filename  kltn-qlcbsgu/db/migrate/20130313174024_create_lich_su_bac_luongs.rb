class CreateLichSuBacLuongs < ActiveRecord::Migration
  def self.up
    create_table :lich_su_bac_luongs do |t|
      t.references :bac_luong
      t.references :can_bo_thong_tin
      t.date :ngay_thay_doi_bac
      t.string :ghi_chu
      
      t.timestamps
    end
  end

  def self.down
    drop_table :lich_su_bac_luongs
  end
end