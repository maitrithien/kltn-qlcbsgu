class CreateCanBoTrinhDos < ActiveRecord::Migration
  def self.up
    create_table :can_bo_trinh_dos do |t|
      t.references :can_bo_thong_tin
      t.references :hoc_ham
      t.references :hoc_vi
      t.references :trinh_do_chuyen_mon
      t.string :tieng_anh
      t.string :tin_hoc
      t.string :trinh_do_hoc_van
      t.string :trinh_do_ll_ct
      
      t.timestamps
    end
  end

  def self.down
    drop_table :can_bo_trinh_dos
  end
end