class AddChucVuIdToCanBoThongTin < ActiveRecord::Migration
  def change
    add_column :can_bo_thong_tins, :chuc_vu_id, :integer
  end
end
