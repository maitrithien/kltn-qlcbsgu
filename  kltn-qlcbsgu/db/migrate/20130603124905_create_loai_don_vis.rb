class CreateLoaiDonVis < ActiveRecord::Migration
  def self.up
    create_table :loai_don_vis do |t|
      t.string :ten_loai_don_vi
      t.string :ghichu
      
      t.timestamps
    end
  end

  def self.down
    drop_table :loai_don_vis
  end
end