class CreateHocHams < ActiveRecord::Migration
  def self.up
    create_table :hoc_hams do |t|
      t.string :ten_hoc_ham
      t.string :ghi_chu
      
      t.timestamps
    end
  end

  def self.down
    drop_table :hoc_hams
  end
end