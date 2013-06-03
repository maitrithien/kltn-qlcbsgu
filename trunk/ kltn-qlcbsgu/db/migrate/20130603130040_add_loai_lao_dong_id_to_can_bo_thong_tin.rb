class AddLoaiLaoDongIdToCanBoThongTin < ActiveRecord::Migration
  def change
    add_column :can_bo_thong_tins, :loai_lao_dong_id, :integer
  end
end
