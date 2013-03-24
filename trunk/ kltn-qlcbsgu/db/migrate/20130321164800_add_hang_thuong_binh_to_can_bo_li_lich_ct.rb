class AddHangThuongBinhToCanBoLiLichCt < ActiveRecord::Migration
  def change
    add_column :can_bo_li_lich_cts, :hang_thuong_binh_id, :integer
  end
end
