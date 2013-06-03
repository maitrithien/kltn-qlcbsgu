class CreateCongViecs < ActiveRecord::Migration
  def self.up
    create_table :cong_viecs do |t|
      t.string :ten_cong_viec
      t.string :ghichu
      
      t.timestamps
    end
  end

  def self.down
    drop_table :cong_viecs
  end
end