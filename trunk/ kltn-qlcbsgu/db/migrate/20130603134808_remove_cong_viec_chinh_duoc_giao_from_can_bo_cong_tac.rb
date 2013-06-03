class RemoveCongViecChinhDuocGiaoFromCanBoCongTac < ActiveRecord::Migration
  def up
    remove_column :can_bo_cong_tacs, :cong_viec_chinh_duoc_giao
  end

  def down
    add_column :can_bo_cong_tacs, :cong_viec_chinh_duoc_giao, :string
  end
end
