class CreateHocVis < ActiveRecord::Migration
  def self.up
    create_table :hoc_vis do |t|
      t.string :ten_hoc_vi
      t.string :ghi_chu
      
      t.timestamps
    end
  end

  def self.down
    drop_table :hoc_vis
  end
end