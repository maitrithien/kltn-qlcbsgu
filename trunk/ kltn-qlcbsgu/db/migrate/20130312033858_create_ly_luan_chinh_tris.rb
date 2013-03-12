class CreateLyLuanChinhTris < ActiveRecord::Migration
  def self.up
    create_table :ly_luan_chinh_tris do |t|
      t.string :trinh_do
      t.string :ghi_chu
      
      t.timestamps
    end
  end

  def self.down
    drop_table :ly_luan_chinh_tris
  end
end