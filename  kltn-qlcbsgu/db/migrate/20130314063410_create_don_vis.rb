class CreateDonVis < ActiveRecord::Migration
  def self.up
    create_table :don_vis do |t|
      t.string :ten_don_vi
      t.string :dia_chi
      t.string :so_dien_thoai
      
      t.timestamps
    end
  end

  def self.down
    drop_table :don_vis
  end
end