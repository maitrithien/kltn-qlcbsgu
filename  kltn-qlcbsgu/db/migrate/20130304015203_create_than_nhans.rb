class CreateThanNhans < ActiveRecord::Migration
  def self.up
    add_column :than_nhans, :ho_ten, :string, :null => false
    create_table :than_nhans do |t|
      t.references :can_bo_thong_tin
      t.string :quan_he_voi_cb, :unique_id => true
      t.integer :nam_sinh
      t.string :nghe_nghiep
      
      t.timestamps
    end

    execute<<-SQL
    ALTER TABLE thanh_nhans ADD UNIQUE(quan_he_voi_cb)
    SQL
  end

  def self.down
    drop_table :than_nhans
  end
end