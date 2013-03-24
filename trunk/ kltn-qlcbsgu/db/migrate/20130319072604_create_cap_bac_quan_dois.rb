class CreateCapBacQuanDois < ActiveRecord::Migration
  def self.up
    create_table :cap_bac_quan_dois do |t|
      t.string :ten_cap_bac
      t.string :ghi_chu
      
      t.timestamps
    end
  end

  def self.down
    drop_table :cap_bac_quan_dois
  end
end