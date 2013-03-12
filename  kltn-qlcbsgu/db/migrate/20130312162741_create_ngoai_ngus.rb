class CreateNgoaiNgus < ActiveRecord::Migration
  def self.up
    create_table :ngoai_ngus do |t|
      t.string :ten_ngoai_ngu
      t.string :ghi_chu
      
      t.timestamps
    end
  end

  def self.down
    drop_table :ngoai_ngus
  end
end