class AddGhiChuToThanNhan < ActiveRecord::Migration
  def change
    add_column :than_nhans, :ghi_chu, :text
  end
end
