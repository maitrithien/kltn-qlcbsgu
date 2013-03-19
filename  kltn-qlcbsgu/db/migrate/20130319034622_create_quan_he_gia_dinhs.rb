class CreateQuanHeGiaDinhs < ActiveRecord::Migration
  def self.up
    create_table :quan_he_gia_dinhs do |t|
      t.string :ten_quan_he
      t.string :ghi_chu
      
      t.timestamps
    end
  end

  def self.down
    drop_table :quan_he_gia_dinhs
  end
end