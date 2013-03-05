class CreateThanNhans < ActiveRecord::Migration
  def self.up
    create_table :than_nhans do |t|
      t.references :can_bo_thong_tin
      t.string :ho_ten, :null => false
      t.string :quan_he_voi_cb, :unique_id => true
      t.integer :nam_sinh
      t.string :nghe_nghiep
	  t.string :ho_ten, :null => false
      
      t.timestamps
    end
  end

  def self.down
    drop_table :than_nhans
  end
end