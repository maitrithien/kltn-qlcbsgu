class CreateQuanLyNhaNuocs < ActiveRecord::Migration
  def self.up
    create_table :quan_ly_nha_nuocs do |t|
      t.string :trinh_do
      t.string :ghi_chu
      
      t.timestamps
    end
  end

  def self.down
    drop_table :quan_ly_nha_nuocs
  end
end