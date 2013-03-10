class CreateLoaiQuyetDinhs < ActiveRecord::Migration
  def self.up
    create_table :loai_quyet_dinhs do |t|
      t.string :ten_loai_qd
      t.string :ghi_chu
      
      t.timestamps
    end
  end

  def self.down
    drop_table :loai_quyet_dinhs
  end
end