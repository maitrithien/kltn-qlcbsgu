class CreateNgaches < ActiveRecord::Migration
  def self.up
    create_table :ngaches do |t|
      t.string :ma_ngach
      t.string :ten_ngach
      t.integer :nien_han
      t.string :ghi_chu
      
      t.timestamps
    end
  end

  def self.down
    drop_table :ngaches
  end
end