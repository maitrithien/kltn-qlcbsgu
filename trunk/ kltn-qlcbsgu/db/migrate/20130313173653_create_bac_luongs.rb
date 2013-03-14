class CreateBacLuongs < ActiveRecord::Migration
  def self.up
    create_table :bac_luongs do |t|
      t.references :ngach
      t.integer :bac
      t.float :he_so_luong
      t.string :ghi_chu
      t.boolean :vuot_khung ,:default =>false
      t.timestamps
    end
  end

  def self.down
    drop_table :bac_luongs
  end
end