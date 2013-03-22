class AddBacLuongToCanBoThongTin < ActiveRecord::Migration
  def change
    add_column :can_bo_thong_tins, :bac_luong_id, :integer
  end
end
