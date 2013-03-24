class RemoveThuongBinhHangFromCanBoLiLichct < ActiveRecord::Migration
  def up
    remove_column :can_bo_li_lich_cts, :thuong_binh_hang
  end
end
