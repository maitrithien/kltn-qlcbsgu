class CreateLoaiLaoDongs < ActiveRecord::Migration
  def self.up
    create_table :loai_lao_dongs do |t|
      t.string :ten_loai_lao_dong
      t.string :ghichu
      
      t.timestamps
    end
  end

  def self.down
    drop_table :loai_lao_dongs
  end
end