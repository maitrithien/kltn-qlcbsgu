class CreateTrinhDoChuyenMons < ActiveRecord::Migration
  def self.up
    create_table :trinh_do_chuyen_mons do |t|
      t.string :ten_trinh_do_cm
      t.string :ghi_chu
      
      t.timestamps
    end
  end

  def self.down
    drop_table :trinh_do_chuyen_mons
  end
end