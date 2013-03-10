class CreateQuyetDinhs < ActiveRecord::Migration
  def self.up
    create_table :quyet_dinhs do |t|
      t.references :loai_quyet_dinh
      t.string :so_qd
      t.date :ngay_ra_qd
      t.string :noi_dung_tom_tat
      t.string :tep_tin_dinh_kem
      
      t.timestamps
    end
  end

  def self.down
    drop_table :quyet_dinhs
  end
end